//This file opens a bdf file and read the information
//The bdf data have been saved in ASCII format, unless otherwise specified
//This file is a mex file to be used with Matlab

//Upload the libraries
#include <iostream>
#include <fstream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <iomanip>   
#include "mex.h"
#include "math.h"
   
using namespace std;	

//*********************************************************************************************//
//Global variables

int srate;
int n_chan;
int s_data;
double res_data;
//double offset;

int bytes_data = 3;
int **matrix_data;	//Matrix where to save the EEG data;
double **matrix_data_compl_2;	//Matrix where to save the EEG after being complement 2 conversion; 

int *vect_trig;		//Vector where to save the triggers data;
int **matrix_trig;	//Matrix where to save the latency and trigger code for each event;

FILE *file_data;	//Initialize a FILE type variable to open the binary file
//*********************************************************************************************//

	
//*********************************************************************************************//
//Body of the MEX function
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
	
//Define the macros for the output of the mex code
#define byte_1 plhs[0]
#define byte_2 plhs[1]
#define byte_3 plhs[2]
#define byte_4 plhs[3]
#define byte_5 plhs[4]
#define byte_6 plhs[5]
#define byte_7 plhs[6]
#define byte_8 plhs[7]
#define byte_9 plhs[8]
#define byte_10 plhs[9]
#define byte_11 plhs[10]
#define byte_12 plhs[11]
#define byte_13 plhs[12]
#define byte_14 plhs[13]
#define byte_15 plhs[14]
#define byte_16 plhs[15]
#define byte_17 plhs[16]
#define byte_18 plhs[17]
#define byte_19 plhs[18]
#define byte_20 plhs[19]
#define byte_21 plhs[20]
#define res_data_output plhs[21]
#define sampl_freq plhs[22]
#define data_bdf_c2 plhs[23]	
#define trig_data_event plhs[24]
#define trig_data_latency plhs[25]
#define event_status plhs[26]
		
  char *name_bdf;
  int   buflen,status;

//*******************************************************************************************//
//*******************************************************************************************//
// Check for proper number of arguments
  if (nrhs != 1) {
	  
    mexErrMsgTxt("The name of the bdf file to be opened is missing");
	
	return;
	
  }
  
// Checking that the name of the bdf file has been inserted correctly
  if (mxIsChar(prhs[0]) != 1){
	  
    mexErrMsgTxt("The name of the bdf file must be a string");
	
	return;
	
  }

// Input must be a row vector
  if (mxGetM(prhs[0]) != 1){
	  
    mexErrMsgTxt("The name of the bdf file must be a string");
    
  }
  
  if (nlhs != 27) {
	  
    mexErrMsgTxt("Wrong number of output. 27 output are needed");
	
	return;
	
  }
//Get the length of the input file*/
  buflen = (mxGetM(prhs[0]) * mxGetN(prhs[0])) + 1;

  /* Allocate memory for input strings. */
  name_bdf = (char *)mxCalloc(buflen, sizeof(char));
  
// Copy the string data from prhs[0] into a C string name_bdf 
  status = mxGetString(prhs[0], name_bdf, buflen);	//Reads the input string (prhs[0]) into "name_bdf"
  if (status != 0) {
	  
    mexWarnMsgTxt("Not enough space. String is truncated.");
	
	return;
	
  }
//*******************************************************************************************//
//*******************************************************************************************//
  
int length_data_int = 10;  
int length_data_char = 10000;  
int *buff_int = new int[length_data_int];	//Reads information saved as integer values;  
char * buff_char = new char [length_data_char];	//Reads information saved in ASCII format; 


file_data = fopen(name_bdf,"rb");	//Open the bdf file

  
//*******************************************************************************************//
//*******************************************************************************************//
//Start reading each byte 

int *temp_pointer; //Pointer used for the conversion of char to int, where necessary; 
int *temp_byte;	//Variable used to point to the output of mex
double *temp_pointer_d;
double *temp_byte_d;

//The first byte is an integer number
fread(buff_int, 1, 1, file_data); 
buff_int[1] = '\0';	//Null terminate the buffer to avoid extra unwanted characters to be saved in your buffer
byte_1 = mxCreateNumericMatrix(1, 1, mxUINT8_CLASS, mxREAL);
	temp_byte = (int *)mxGetData(byte_1);
	temp_byte[0] = *buff_int;
  

//Bytes 2-8 are ASCII and they represent the word BIOSEMI
fread(buff_char, 1, 7, file_data); 
buff_char[7] = '\0';
byte_2 = mxCreateString(buff_char);


//80 bytes: Local Subject Identification
fread(buff_char, 1, 80, file_data); 
buff_char[80] = '\0';
byte_3 = mxCreateString(buff_char);
		

//80 bytes: Local Recording identification
fread(buff_char, 1, 80, file_data); 
buff_char[80] = '\0';
byte_4 = mxCreateString(buff_char);


//8 bytes: Start date of recording
fread(buff_char, 1, 8, file_data); 
buff_char[8] = '\0';
byte_5 = mxCreateString(buff_char);


//8 bytes: Start time of recording
fread(buff_char, 1, 8, file_data); 
buff_char[8] = '\0';
byte_6 = mxCreateString(buff_char);

//8 bytes: Number of bytes in header record
fread(buff_char, 1, 8, file_data); 
buff_char[8] = '\0';
byte_7 = mxCreateString(buff_char);


//44 bytes: Version of data format
fread(buff_char, 1, 44, file_data); 
buff_char[44] = '\0';
byte_8 = mxCreateString(buff_char);

//8 bytes: Number of data record
fread(buff_char, 1, 8, file_data); 
buff_char[8] = '\0';
byte_9 = mxCreateNumericMatrix(1, 1, mxUINT16_CLASS, mxREAL);
	temp_byte = (int *)mxGetData(byte_9);
	s_data = atoi(buff_char);
	temp_pointer = &s_data;
	temp_byte[0] = *temp_pointer;

//8 bytes: Duration of data record, in seconds
fread(buff_char, 1, 8, file_data); 
buff_char[8] = '\0';
byte_10 = mxCreateString(buff_char);	

//4 bytes: Number of channels in data record
fread(buff_char, 1, 4, file_data); 
buff_char[4] = '\0';
byte_11 = mxCreateNumericMatrix(1, 1, mxUINT8_CLASS, mxREAL);
	temp_byte = (int *)mxGetData(byte_11);
	n_chan = atoi(buff_char);//(int)buffer[0] - '0';
	temp_pointer = &n_chan;
	temp_byte[0] = *temp_pointer;

//Nx16 bytes: Labels of channels
fread(buff_char, n_chan, 16, file_data);
buff_char[n_chan*16] = '\0'; 
byte_12 = mxCreateString(buff_char);

//Nx80 bytes: Transducer type
fread(buff_char, n_chan, 80, file_data); 
buff_char[n_chan*80] = '\0';
byte_13 = mxCreateString(buff_char);


//Nx8 bytes: Physical dimension of channels
fread(buff_char, n_chan, 8, file_data); 
buff_char[n_chan*8] = '\0';
byte_14 = mxCreateString(buff_char);


//Nx8 bytes: Physical minimum in units of physical dimension
fread(buff_char, n_chan, 8, file_data);
buff_char[n_chan*8] = '\0';
byte_15 = mxCreateDoubleMatrix(1, 1, mxREAL);
	temp_byte_d = mxGetPr(byte_15);
	double min_physic = (double)atoi(buff_char); 
	temp_pointer_d = &min_physic;
	temp_byte_d[0] = *temp_pointer_d;


//Nx8 bytes: Physical maximum in units of physical dimension
fread(buff_char, n_chan, 8, file_data); 
buff_char[n_chan*8] = '\0';
byte_16 = mxCreateDoubleMatrix(1, 1, mxREAL);
	temp_byte_d = mxGetPr(byte_16);
	double max_physic = (double)atoi(buff_char); 
	temp_pointer_d = &max_physic;
	temp_byte_d[0] = *temp_pointer_d;

//Nx8 bytes: Digital minimum
fread(buff_char, n_chan, 8, file_data); 
buff_char[n_chan*8] = '\0';
byte_17 = mxCreateDoubleMatrix(1, 1, mxREAL);
	temp_byte_d = mxGetPr(byte_17);
	double min_dig = (double)atoi(buff_char); 
	temp_pointer_d = &min_dig;
	temp_byte_d[0] = *temp_pointer_d;

//Nx8 bytes: Digital maximum
fread(buff_char, n_chan, 8, file_data);
buff_char[n_chan*8] = '\0'; 
byte_18 = mxCreateDoubleMatrix(1, 1, mxREAL);
	temp_byte_d = mxGetPr(byte_18);
	double max_dig = (double)atoi(buff_char); 
	temp_pointer_d = &max_dig;
	temp_byte_d[0] = *temp_pointer_d;

res_data = (max_physic - min_physic)/(max_dig - min_dig);	//Resolution of the data;
	//offset = max_physic - res_data*max_dig
res_data_output = mxCreateDoubleMatrix(1, 1, mxREAL);
	temp_byte_d = mxGetPr(res_data_output);
	temp_pointer_d = &res_data;
	temp_byte_d[0] = *temp_pointer_d;

//Nx80 bytes: Pre-filtering
fread(buff_char, n_chan, 80, file_data); 
buff_char[n_chan*80] = '\0';
byte_19 = mxCreateString(buff_char);

//Nx8 bytes: Number of samples in each data record
//(Sample-rate if Duration of data record = "1")
fread(buff_char, n_chan, 8, file_data); 
buff_char[n_chan*8] = '\0';
byte_20 = mxCreateString(buff_char);

//Store the sampling frequency
char *srate_char = new char[1];
bool flag_srate = true;
int track_srate = 0;

while (flag_srate == 1){

srate_char[track_srate] = buff_char[track_srate];

if (srate_char[track_srate] == ' '){
	
	flag_srate = false;
	
}

track_srate++;

}

sampl_freq = mxCreateNumericMatrix(1, 1, mxUINT16_CLASS, mxREAL);
temp_byte = (int *)mxGetData(sampl_freq);
	int srate_int = atoi(srate_char);
	temp_pointer = &srate_int;
	temp_byte[0] = *temp_pointer;
	
//Nx32 bytes: Reserved bytes
//(Sample-rate if Duration of data record = "1")
fread(buff_char, n_chan, 32, file_data);
buff_char[n_chan*32] = '\0'; 
byte_21 = mxCreateString(buff_char);
	
//*******************************************************************************************//
//*******************************************************************************************//
  
  delete [] buff_char;	//Clean the memory
  delete [] buff_int;	//Clean the memory

//mexPrintf("Call# = %d\n",srate_int);
//mexPrintf("Call# = %d\n",s_data);

//*******************************************************************************************//
//*******************************************************************************************//
//Extract the data and the triggers

mxArray *data_bdf = mxCreateNumericMatrix(n_chan - 1, srate_int*bytes_data*s_data, mxUINT8_CLASS, mxREAL);
uint8_t *temp_bdf = (uint8_t *)mxGetData(data_bdf);	

data_bdf_c2 = mxCreateDoubleMatrix(n_chan - 1, srate_int*s_data,mxREAL);
double *temp_bdf_c2 = mxGetPr(data_bdf_c2);	

mxArray *trig_data = mxCreateNumericMatrix(1, srate_int*bytes_data*s_data, mxUINT8_CLASS, mxREAL);
uint8_t *temp_trig_data = (uint8_t *)mxGetData(trig_data);		

mxArray *trig_data_event_temp = mxCreateNumericMatrix(1, srate_int*s_data, mxUINT8_CLASS, mxREAL);
uint8_t *temp_trig_data_event = (uint8_t *)mxGetData(trig_data_event_temp);

mxArray *trig_data_latency_temp = mxCreateNumericMatrix(1, srate_int*s_data, mxINT32_CLASS, mxREAL);
int *temp_trig_data_latency = (int *)mxGetData(trig_data_latency_temp);

mxArray *event_status_temp = mxCreateNumericMatrix(1, srate_int*s_data, mxINT32_CLASS, mxREAL);
int *temp_event_status = (int *)mxGetData(event_status_temp);

size_t dim_array;
dim_array = mxGetNumberOfElements(trig_data_event_temp);

uint8_t temp_data;
int track_data;
int step_data;
int track_data_c2;
int track_trig;
  
int temp_sample; 

  //int uu = (int)fmod(5, 3);
  //mexPrintf("Call# = %d\n",uu);
  //mexPrintf("Channels recorded# = %d\n",n_chan - 1);
 for (int kk = 1; kk < n_chan + 1;kk++){
	 
if (kk < n_chan){
	
	//mexPrintf("Channel#%d read successfully\n",kk);
	
	 track_data = kk - 1;
	 track_data_c2 = kk - 1;
	 
fseek (file_data,(n_chan + 1)*256 + (kk - 1)*srate_int*bytes_data,SEEK_SET);	//Positioning the pointer to read the data for each channel
	step_data = 1;
	for (int count_samples = 0;(count_samples < srate_int*bytes_data*s_data && ((temp_data = fgetc(file_data)) != EOF)); count_samples++){
       
	   temp_bdf[track_data] = temp_data;//fgetc(file_data_f);
	   
	   //After 3 bytes, makes the complement-2 conversion
	   if ((int)fmod(count_samples + 1, bytes_data) == 0){
		
		temp_sample = temp_bdf[track_data - (n_chan - 1)*2] + temp_bdf[track_data - (n_chan - 1)]*pow(2,8) + temp_bdf[track_data]*pow(2,16);
		
		if (temp_sample >= pow(2,23))
{
	
	
	temp_bdf_c2[track_data_c2] = (temp_sample - pow(2,24))*res_data; //+ offset;
	
}

else{
	
temp_bdf_c2[track_data_c2] = temp_sample*res_data; //+ offset;

}

				if (track_data_c2 == 9){
/*
int rr = (temp_sample - pow(2,24));
					mexPrintf("Call# = %d\n",temp_sample);
					mexPrintf("Call# = %d\n",rr);
					mexPrintf("Call# = %f\n",res_data);
					mexPrintf("Call# = %f\n",temp_bdf_c2[track_data_c2]);
	*/				
				
				}
			
		 track_data_c2 = track_data_c2 + n_chan - 1;
	   
	   }
		
		track_data = track_data + n_chan - 1;
		
		if (count_samples == step_data*srate_int*bytes_data - 1){
			
			fseek (file_data,(n_chan + 1)*256 + (kk - 1)*srate_int*bytes_data + step_data*(n_chan)*srate_int*bytes_data,SEEK_SET);	//Skip the next second for each channel;
			step_data++;
			
		}
	}
	
}

//Extracting the triggers
else{
	
	
	track_trig = 0;
	fseek (file_data,(n_chan + 1)*256 + (kk - 1)*srate_int*bytes_data,SEEK_SET);
		
		step_data = 1;
		for (int count_samples = 0;(count_samples < srate_int*bytes_data*s_data && ((temp_data = fgetc(file_data)) != EOF)); count_samples++){
        
		temp_trig_data[count_samples] = temp_data;
        
		//After 3 bytes, check if an event is present and extract the trigger code and the latency  
	   if ((int)fmod(count_samples + 1, bytes_data) == 0){
			
		if (track_trig > 0){
			
		if (((temp_trig_data[count_samples - 2] != 0) || (temp_trig_data[count_samples - 1] != 0)) && (((temp_trig_data[count_samples - 2] - temp_trig_data[count_samples - 5]) !=0) ||  ((temp_trig_data[count_samples - 1] - temp_trig_data[count_samples - 4])!= 0))){
			
		temp_trig_data_event[track_trig] = temp_trig_data[count_samples - 2] + temp_trig_data[count_samples - 1]*pow(2,8);
		temp_trig_data_latency[track_trig] = (count_samples + 1)/bytes_data;
		temp_event_status[track_trig] = temp_trig_data[count_samples];
				
		track_trig++;
		}
		}
		
		else{
			
			if ((temp_trig_data[count_samples - 2] != 0) || (temp_trig_data[count_samples - 1] != 0)){
		
		temp_trig_data_event[track_trig] = temp_trig_data[count_samples - 2] + temp_trig_data[count_samples - 1]*pow(2,8);
		temp_trig_data_latency[track_trig] = (count_samples + 1)/bytes_data;
		temp_event_status[track_trig] = temp_trig_data[count_samples];  
		  
		track_trig++;
		}
			
		}
	   }
	
		
		if (count_samples == step_data*srate_int*bytes_data - 1){
			
			fseek (file_data,(n_chan + 1)*256 + (kk - 1)*srate_int*bytes_data + step_data*(n_chan)*srate_int*bytes_data,SEEK_SET);	//Skip the next second for each channel;
			step_data++;
			
		}
		
				}
	}
}

if (track_trig < dim_array)
//Now save the output in arrays of the lenght of the events detected 
trig_data_event = mxCreateNumericMatrix(1, track_trig, mxUINT8_CLASS, mxREAL);
uint8_t *trig_data_event_f = (uint8_t *)mxGetData(trig_data_event);

trig_data_latency = mxCreateNumericMatrix(1, track_trig, mxINT32_CLASS, mxREAL);
int *trig_data_latency_f = (int *)mxGetData(trig_data_latency);

event_status = mxCreateNumericMatrix(1, track_trig, mxINT32_CLASS, mxREAL);
int *event_status_f = (int *)mxGetData(event_status);

for (int kk = 0; kk < track_trig;kk++){
	
	trig_data_event_f[kk] = temp_trig_data_event[kk];
	trig_data_latency_f[kk] = temp_trig_data_latency[kk];
	event_status_f[kk] = temp_event_status[kk];
}


 //mexPrintf("Triggers extracted# = %d\n", track_trig);
 //mexPrintf("Size of the array# = %d\n", dim_array);
 /*
  mexPrintf("Trigger# = %d\n",track_trig);
  mexPrintf("Code# = %d\n",temp_trig_data_event[0]);
  mexPrintf("Latency# = %d\n",temp_trig_data_latency[0]);
  mexPrintf("Code# = %d\n",temp_trig_data_event[1]);
  mexPrintf("Latency# = %d\n",temp_trig_data_latency[1]);
  mexPrintf("Code# = %d\n",temp_trig_data_event[2]);
  mexPrintf("Latency# = %d\n",temp_trig_data_latency[2]);
  mexPrintf("Code# = %d\n",temp_trig_data_event[3]);
  mexPrintf("Latency# = %d\n",temp_trig_data_latency[3]);
  */

  fclose(file_data);
//*******************************************************************************************//
//*******************************************************************************************//
    
  return;
  
}
