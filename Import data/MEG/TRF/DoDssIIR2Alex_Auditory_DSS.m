function DoDssIIR2Alex_Auditory_DSS(Forder,freqL,freqH,mat_file_directory,n_components,SF_MEG_Data,filter_rm)

%In this version of DoDSS, both autocorrelation matrices are calculated as
%the mean of the autocorrelation matrices in different experiment
%conditions
%created by Nai 03/09
%calculate the covariance matrix block by block, modified by Nai 06/23/09
%based on the trial rejection code to select channels, modified by Nai 07/03/09

% S------filter design
clear x;
clear y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%FIR filter to process the Raw MEG data
b = fir1(Forder,[freqL freqH]/(SF_MEG_Data/2));
a = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

cd(mat_file_directory)

dir_files = dir;

[files_number] = size(dir_files,1);

track_subjects = 0;

for ii = 3:files_number
      
  matrix_file = dir_files(ii).name;
  
  display(['Current file: ' matrix_file])
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      track_subjects = track_subjects + 1;
      
    selected_file = load(matrix_file);
    
    try
    
    clean = selected_file.data_exported.eeg_data_aligned(:,:,:);
     
        
        bad_channels = selected_file.data_exported.bad_channels + 1; 
%Indeces are increased to adapt to the matlab standard (index starts from "1" and not from "0" like in 
%the case of the MEG)  

%prepare data
%and also calculate autocorrelation matrices
% cmat1 is the sphering autocorrelation matrix
% cmat2 is the biased autocorrelation matrix

% Clearing the variables
clear cmat1;
clear cmat2;
clear sumch;
clear inducedclean;
clear evokedclean;

   
    size_data = size(clean,2);
    
    if size_data == 192 %KIT data
        
    sumch=squeeze(sum(abs(clean(:,1:157,:)),2));
    
    else
       
        sumch=squeeze(sum(abs(clean),2));
        
    end
    
    for ind=1:size(sumch,2)
        clean(sumch(:,ind)>1e5,:,ind)=0;    %It is arbitrary
    end
    
  if filter_rm == 1
      
    for trl=1:1:size(clean,3)
        
        clean(:,:,trl) = filter(b,a,clean(:,:,trl));
    
    end
    
   
    %Data have been shifted by Forder/2 + 1 to compensate for the phase-shift introduced by the FIR filter   
     [time_delay_fir freq_delay_fir]  = grpdelay(b,1); 
     clean = clean(round(mean(time_delay_fir)) + 1:end,:,:); 
     
  end
  
   if size_data == 192 %KIT data
      
    clean=clean(:,setdiff([1:157],[bad_channels]),:); 
    
   else
      
       clean=clean(:,setdiff([1:size_data],[bad_channels]),:); 
       
   end
    
    inducedclean=unfold(clean);
    cmat1 = inducedclean'*inducedclean;
    evokedclean=sum(clean,3);
    cmat2 = evokedclean'*evokedclean*size(clean,3)^2;


keep2=10.^-13;
keep1=[];
[todss,fromdss,ratio,pwr]=dss0(cmat1,cmat2,keep1,keep2);
todss=pad02D(todss,bad_channels);

%% Plotting the scalp map for each DSS to check which one is auditory
try
for auditory_DSS = 1:length(n_components)
    
headmap=padN(fromdss(n_components(auditory_DSS),:),bad_channels);
headmap(bad_channels)=0;
STDheadmap=std(headmap(~isnan(headmap)));
headmap=headmap./STDheadmap;
%headmap(56)=NaN;
headmap(bad_channels) = NaN;

figure;megtopoplot(headmap);%*sign(headmap(97)));

warning off
mkdir('Save_Scalp_Maps')
warning on

cd([mat_file_directory '\' 'Save_Scalp_Maps'])

saveas(gcf,['DSS_' matrix_file '_' num2str(auditory_DSS) '.fig'])

fig_tag = gcf;
close(fig_tag)

cd ..

end

catch
   
    close gcf
    display('No scalp maps')
    
end

clear *clean
 %pause

 %% Saving the DSS and the rotation matrix of the DSS to be used for future analysis
 warning off
 mkdir('Save_DSS')
 warning on
 
 cd([mat_file_directory '\' 'Save_DSS'])
 
 % First file upoloaded
 if size_data == 192
     
 dss_first_file = fold(unfold(selected_file.data_exported.eeg_data_aligned(:,1:157,:))*todss,size(selected_file.data_exported.eeg_data_aligned(:,1:157,:),1));   % DSS components
 
 else
    
     dss_first_file = fold(unfold(selected_file.data_exported.eeg_data_aligned)*todss,size(selected_file.data_exported.eeg_data_aligned,1));   % DSS components
      
 end
 data_exported.dss = dss_first_file;      
        data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
            data_exported.rotation_matrix = todss;
                save(['DSS_' matrix_file],'data_exported')  
 
 data_exported = [];               
  
         cd ..
 
    catch
        
        track_subjects = track_subjects - 1;
        
    end
  end
  
end

if track_subjects > 0

message = 'All the DSS and scalp map have been extracted and saved';

        msgbox(message,'DSS and scalp map saved','warn','replace');

else
    
    message = 'One or more files in the directory did not have the correct field structure and no DSS were extracted';

        msgbox(message,'DSS and scalp map not extracted for one or more files','warn','replace');
    
end