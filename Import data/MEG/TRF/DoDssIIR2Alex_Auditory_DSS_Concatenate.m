function DoDssIIR2Alex_Auditory_DSS_Concatenate(Forder,freqL,freqH,mat_file_directory,n_components,SF_MEG_Data,filter_rm)

%In this version of DoDSS, both autocorrelation matrices are calculated as
%the mean of the autocorrelation matrices in different experiment
%conditions
%created by Nai 03/09
%calculate the covariance matrix block by block, modified by Nai 06/23/09
%based on the trial rejection code to select channels, modified by Nai 07/03/09

% S------filter design
clean = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%FIR filter to process the Raw MEG data
b = fir1(Forder,[freqL freqH]/(SF_MEG_Data/2));
a = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

cd(mat_file_directory)

dir_files = dir;

[files_number] = size(dir_files,1);

track_subjects = 0;

temp_save_data = [];
temp_save_name_dat = [{}];

for ii = 3:files_number
      
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      display(['Current file: ' matrix_file])
      temp_save_name_dat = [temp_save_name_dat;{matrix_file}];
      
      track_subjects = track_subjects + 1;
      
    selected_file = load(matrix_file);
    
    try
    temp_size_clean = [];
        temp_size_clean = size(clean,1);
        
            for tt = 1:size(selected_file.data_exported.eeg_data_aligned,3)
        
     clean(temp_size_clean + 1:size(selected_file.data_exported.eeg_data_aligned(:,:,tt),1) + temp_size_clean,:,tt) = selected_file.data_exported.eeg_data_aligned(:,:,tt);
    temp_save_data(temp_size_clean + 1:size(selected_file.data_exported.eeg_data_aligned(:,:,tt),1) + temp_size_clean,:,tt) = selected_file.data_exported.eeg_data_aligned(:,:,tt);
    
        
            end
 
       
        if track_subjects == 1
            
    try 
            
bad_channels = (selected_file.data_exported.bad_channels + 1); %Channels to be removed from the analysis. 



    catch
     
        bad_channels = selected_file.data_exported.bad_channels + 1;
        
    end

        end
   
        catch
     
            track_subjects = track_subjects - 1;
            
  end
        
  end
  
  
end
    

if track_subjects > 0
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
 
 if  size_data == 192 %KIT format
   
     sumch=squeeze(sum(abs(clean(:,1:157,:)),2));
    
 else
    
     sumch=squeeze(sum(abs(clean),2));
     
 end
     
    for ind=1:size(sumch,2)
     clean(sumch(:,ind)>1e5,:,ind)=0;    %It is arbitrary
    end
  
  if filter_rm == 1
      
    for trl=1:1:size(clean,3)
        
        clean(:,:,trl)=filter(b,a,clean(:,:,trl));
    
    end
    
    %Data have been shifted by Forder/2 + 1 to compensate for the phase-shift introduced by the FIR filter   
     [time_delay_fir freq_delay_fir]  = grpdelay(b,1); 
     clean=clean(round(mean(time_delay_fir)) + 1:end,:,:); 
  
  end   
     
  if  size_data == 192 %KIT format
    
      clean=clean(:,setdiff([1:157],[bad_channels]),:); 
    
  else
     
      clean=clean(:,setdiff([1:size_data],[bad_channels]),:); 
          
  end
  
    inducedclean = unfold(clean);
    cmat1 = inducedclean'*inducedclean;
    evokedclean = sum(clean,3);
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
headmap(bad_channels) = NaN;

figure;megtopoplot(headmap);%*sign(headmap(97)));

warning off
mkdir('Save_Scalp_Maps_Conc')
warning on

cd([mat_file_directory '\' 'Save_Scalp_Maps_Conc'])

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

 samples_data = size(temp_save_data,1)/length(temp_save_name_dat);
 
 %% Saving the DSS and the rotation matrix of the DSS to be used for future analysis
 warning off
 mkdir('Save_DSS_Conc')
 warning on
 
 cd([mat_file_directory '\' 'Save_DSS_Conc'])
 
 start_samples = 1;
 step_samples = samples_data;
 end_samples = samples_data;
 
 for kk = 1:length(temp_save_name_dat)
 % First file upoloaded
 dss_first_file = [];
 dss_first_file = fold(unfold(temp_save_data(start_samples:end_samples,1:157,:))*todss,size(temp_save_data(start_samples:end_samples,1:157,:),1));   % DSS components
   data_exported.dss = dss_first_file;      
        data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
            data_exported.rotation_matrix = todss;
                save(['DSS_' cell2mat(temp_save_name_dat(kk,:))],'data_exported')  
 
 data_exported = [];               
 
 start_samples = start_samples + step_samples;
 end_samples = end_samples + samples_data;
 
 end
     
 %Now let's save the concatenate data
 dss_first_file = [];
 
      dss_first_file = fold(unfold(temp_save_data(:,1:157,:))*todss,size(temp_save_data,1));   % DSS components
 
  data_exported.dss = dss_first_file;      
        data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
            data_exported.rotation_matrix = todss;
                
                save('DSS_Concatenated_Data','data_exported')  
 
 data_exported = [];  
 
 
 cd ..
 
  

message = 'All the DSS and scalp map have been extracted and saved';

        msgbox(message,'DSS and scalp map saved','warn','replace');

else
    
    message = 'One or more files in the directory did not have the correct field structure and no DSS were extracted';

        msgbox(message,'DSS and scalp map not extracted for one or more files','warn','replace');
    
end

