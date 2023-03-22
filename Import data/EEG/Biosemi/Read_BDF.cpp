//This file opens a bdf file and read the information
//The bdf data have been saved in ASCII format, unless otherwise specified

//Upload the libraries
#include <iostream>
#include <fstream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <iomanip>   
#include <cstring>
#include <math.h> 

using namespace std;	

class read_bdf_data{
	
	public:
	void read_info_bdf(char *, int *, char *);
	void read_data_bdf(FILE *,int,int,int);
	void read_data_complement_2(uint8_t **,int,int);
	void read_triggers(uint8_t *,int);
	
};

//*********************************************************************************************//
//Global variables

int dur_data;
int srate;
int n_chan;
int s_data;
double res_data;
//double offset;
bool flag_invalid_name = false;

int bytes_data = 3;
uint8_t **matrix_data;	//Matrix where to save the EEG data;
double **matrix_data_compl_2;	//Matrix where to save the EEG after being complement 2 conversion; 

uint8_t *vect_trig;		//Vector where to save the triggers data;
int **matrix_trig;	//Matrix where to save the latency and trigger code for each event;

FILE *file_data;	//Initialize a FILE type variable to open the binary file
//*********************************************************************************************//

//*********************************************************************************************//
//This function reads the information from the header file    
void read_bdf_data::read_info_bdf(char *buffer, int *buff, char *name_file){

//Open the binary file			
//file_data = fopen("Ditch_corticalmodule2.bdf","rb");
file_data = fopen(name_file,"rb");

if (file_data == 0)
{
	
	cout << "\nThe file has not been opened. Check that the name of the file is correct and make sure to include the extension bdf\n" << "\n";

	flag_invalid_name = true;

	return;

}

else
{

	cout << "\nThe files been opened correctly\n";

}

//The first byte is an integer number
fread(buff, 1, 1, file_data); 
buff[1] = '\0';
cout <<  "\nIdentification code (Byte 1): " << *buff << "\n";

//Bytes 2-8 are ASCII and they represent the word BIOSEMI
fread(buffer, 1, 7, file_data); 
cout << "Identification code (Bytes 2-8): " << buffer << "\n";

//80 bytes: Local Subject Identification
fread(buffer, 1, 80, file_data); 
buffer[80] = '\0';
cout << "Local Subject Identification (80 Bytes): " << buffer << "\n"; 

//80 bytes: Local Recording identification
fread(buffer, 1, 80, file_data); 
buffer[80] = '\0';
cout << "Local Recording identification (80 bytes): " << buffer << "\n"; 

//8 bytes: Start date of recording
fread(buffer, 1, 8, file_data); 
buffer[8] = '\0';
cout << "Start date of recording (8 bytes): " << buffer << "\n"; 

//8 bytes: Start time of recording
fread(buffer, 1, 8, file_data);
buffer[8] = '\0'; 
cout << "Start time of recording (8 bytes): " << buffer << "\n";

//8 bytes: Number of bytes in header record
fread(buffer, 1, 8, file_data); 
buffer[8] = '\0';
cout << "Number of bytes in header record(8 bytes): " << buffer << "\n"; 

//44 bytes: Version of data format
fread(buffer, 1, 44, file_data); 
buffer[44] = '\0';
cout << "Version of data format(44 bytes): " << buffer << "\n";

//8 bytes: Number of data record
fread(buffer, 1, 8, file_data);
buffer[8] = '\0'; 
cout << "Number of data record(8 bytes): " << buffer << "\n";
s_data = atoi(buffer);

//8 bytes: Duration of data record, in seconds
fread(buffer, 1, 8, file_data); 
buffer[8] = '\0';
cout << "Duration of data record, in seconds(8 bytes): " << buffer << "\n";
dur_data = atoi(buffer);
	
//4 bytes: Number of channels in data record
fread(buffer, 1, 4, file_data); 
buffer[4] = '\0';
cout << "Number of channels in data record(4 bytes): " << buffer << "\n";
n_chan = atoi(buffer);//(int)buffer[0] - '0';
//cout << n_chan << "\n";

//Nx16 bytes: Labels of channels
fread(buffer, n_chan, 16, file_data); 
buffer[n_chan*16] = '\0';
cout << "Labels of channels(Nx16 bytes): " << buffer << "\n";

//Nx80 bytes: Transducer type
fread(buffer, n_chan, 80, file_data);
buffer[n_chan*80] = '\0'; 
cout << "Transducer type(Nx80 bytes): " << buffer << "\n";

//Nx8 bytes: Physical dimension of channels
fread(buffer, n_chan, 8, file_data); 
buffer[n_chan*8] = '\0';
cout << "Physical dimension of channels(Nx8 bytes): " << buffer << "\n";

//Nx8 bytes: Physical minimum in units of physical dimension
fread(buffer, n_chan, 8, file_data);
buffer[n_chan*8] = '\0';
double min_physic = (double)atoi(buffer); 
cout << "Physical minimum in units of physical dimension(Nx8 bytes): " << buffer << "\n";

//Nx8 bytes: Physical maximum in units of physical dimension
fread(buffer, n_chan, 8, file_data);
buffer[n_chan*8] = '\0'; 
double max_physic = (double)atoi(buffer);
cout << "Physical maximum in units of physical dimension(Nx8 bytes): " << buffer << "\n";

//Nx8 bytes: Digital minimum
fread(buffer, n_chan, 8, file_data); 
buffer[n_chan*8] = '\0';
double min_dig = (double)atoi(buffer);
cout << "Digital minimum(Nx8 bytes): " << buffer << "\n";

//Nx8 bytes: Digital maximum
fread(buffer, n_chan, 8, file_data); 
buffer[n_chan*8] = '\0';
double max_dig = (double)atoi(buffer);
cout << "Digital maximum(Nx8 bytes): " << buffer <<"\n";

res_data = (max_physic - min_physic)/(max_dig - min_dig);	//Resolution of the data;
	//offset = max_physic - res_data*max_dig;
//cout << "Resolution data: " << res_data << "\n";
//Nx80 bytes: Pre-filtering
fread(buffer, n_chan, 80, file_data); 
buffer[n_chan*80] = '\0';
cout << "Pre-filtering(Nx80 bytes): " << buffer << "\n";

//Nx8 bytes: Number of samples in each data record
//(Sample-rate if Duration of data record = "1")
fread(buffer, n_chan, 8, file_data); 
buffer[n_chan*8] = '\0';
cout << "Number of samples in each data record(Nx8 bytes): " << buffer << "\n";

//Store the sampling frequency
char *srate_char = new char[1000000];
bool flag_srate = true;
int track_srate = 0;

while (flag_srate == 1){

srate_char[track_srate] = buffer[track_srate];

if (srate_char[track_srate] == ' '){
	
	flag_srate = false;
	
}

track_srate++;

}

//cout << "Test: " << srate_char;	//Used in debug mode to check that the correct sampling frequency has been extracted
srate = atoi(srate_char)/dur_data;	//Convert the array of characters with the sampling frequency into an integer;
//cout << "Test: " << srate << "\n";
delete [] srate_char; //free memory previously allocated for this array;

//Nx32 bytes: Reserved bytes
//(Sample-rate if Duration of data record = "1")
fread(buffer, n_chan, 32, file_data); 
buffer[n_chan*32] = '\0';
cout << "Reserved bytes(Nx32 bytes): " << buffer << "\n";
			
}
//*********************************************************************************************//

//*********************************************************************************************//
//Perform the complement 2 conversion of the data; 
void read_bdf_data::read_data_complement_2(uint8_t **matrix_data_c2,int rows_data,int columns_data){
	
	cout << "\n";
	cout << "\n" << "Starting the 2-complement conversion" << "\n";
	
	//Dynamical allocation of the matrix used to store the data;
	matrix_data_compl_2 = new double *[rows_data];
	 for (int count = 0; count < rows_data; count++){
		 matrix_data_compl_2[count] = new double [columns_data];
	 
	 }

	
	 uint8_t byte_1;
	 uint8_t byte_2;
	 uint8_t byte_3;
	
	int track_pointer;
	int temp_sample;
	
	//std::ofstream myfile;
	//myfile.open("Data.txt");
	
	for (int ll = 0; ll < rows_data; ll++){
	
	cout << "Chan: " << ll + 1 << "\n";
	
track_pointer = 0;	
for (int kk = 0;kk < columns_data*bytes_data; kk = kk + 3){

byte_1 = matrix_data_c2[ll][kk];
byte_2 = matrix_data_c2[ll][kk + 1];
byte_3 = matrix_data_c2[ll][kk + 2];

/*
if(ll == 0)
{

		myfile << (int)byte_1 << "\n";
		myfile << (int)byte_2 << "\n";
		myfile << (int)byte_3 << "\n";
}

else
{myfile.close();}	
	*/	
temp_sample = byte_1 + byte_2*pow(2,8) + byte_3*pow(2,16);

if (temp_sample >= pow(2,23))
{
	
	matrix_data_compl_2[ll][track_pointer] = (temp_sample - pow(2,24))*res_data; //+ offset;
	
}

else{
	
matrix_data_compl_2[ll][track_pointer] = temp_sample*res_data; //+ offset;

}

/*
if(ll == 0)
{

		myfile << matrix_data_compl_2[0][track_pointer] << "\n";
		
}

else
{myfile.close();}	
*/

//cout << "\n" << "Sample: " << pow(2,23);
//cout << "\n" << "Sample: " << matrix_data_compl_2[ll][track_pointer];
track_pointer++;

}	

//cout<< "Second channel\n";
	}
	
	//Clear the memory
	delete [] matrix_data_c2;
	//cout << "\n" << "Sample: " << matrix_data_compl_2[0][0] << "\n";
	cout << "\nExtraction of data completed" << "\n";
	//cout << "\nTrack pointer: " << track_pointer;	//Used for debugging;
}
//*********************************************************************************************//


//*********************************************************************************************//
//Extract the latency and the trigger code for each event	
	void read_bdf_data::read_triggers(uint8_t *trig_vect, int length_trig_vect){
		
	//Dynamical allocation of the matrix used to store the latency and the trigger code of each event;
	matrix_trig = new int *[length_trig_vect];
	 for (int count = 0; count < length_trig_vect; count++){
	 matrix_trig[count] = new int [2];}
	 
		uint8_t *temp_first_8b = new uint8_t[length_trig_vect];	//Array to store bits 0 - 7;
		uint8_t *temp_second_8b = new uint8_t[length_trig_vect];	//Array to store bits 8 - 15;
		uint8_t *temp_third_8b = new uint8_t[length_trig_vect];	//Array to store bits 16 - 23. These bits are the status bits;

//Store the first set of bits 0 - 7;
int track_pointer = 0;
for (int kk = 0; kk < length_trig_vect*bytes_data; kk = kk + 3){

temp_first_8b[track_pointer] = trig_vect[kk];
track_pointer++;

}	
	
	
	//Store the second set of bits 8 - 15;
track_pointer = 0;
for (int kk = 1; kk < length_trig_vect*bytes_data; kk = kk + 3){

temp_second_8b[track_pointer] = trig_vect[kk];
track_pointer++;

}	

//Store the third set of bits 16 - 23;
track_pointer = 0;
for (int kk = 2; kk < length_trig_vect*bytes_data; kk = kk + 3){

temp_third_8b[track_pointer] = trig_vect[kk];
track_pointer++;

}	

//std::ofstream myfile1;
	//myfile1.open("Data1.txt");
	//std::ofstream myfile2;
	//myfile2.open("Data2.txt");
	
//Now look for events and store them
track_pointer = 0;
for (int kk = 0; kk < length_trig_vect; kk++){

if (kk > 0){
	
if ((temp_first_8b[kk] != 0 || temp_second_8b[kk] != 0) && (((temp_first_8b[kk] - temp_first_8b[kk - 1])!= 0) || (temp_second_8b[kk] - temp_second_8b[kk - 1])!= 0)){
	
	matrix_trig[track_pointer][0] = kk + 1;	//The latency is saved in samples. One has been added to compensate for the fact that C++ starts the first index from 0;
	matrix_trig[track_pointer][1] = temp_first_8b[kk] + temp_second_8b[kk]*pow(2,8);	//Trigger code;
	
	//myfile1 << matrix_trig[track_pointer][0] << "\n";	
	//myfile2 << matrix_trig[track_pointer][1] << "\n";
	
	//cout << "\nTrigger: " << matrix_trig[track_pointer][0] << " - " << matrix_trig[track_pointer][1] << " - #" << track_pointer + 1 << "\n"; //Used for debugging;
	track_pointer++;
}
}


else{
	
	if (temp_first_8b[kk] != 0 || temp_second_8b[kk] != 0){
		
	matrix_trig[track_pointer][0] = kk + 1;	//The latency is saved in samples;
	matrix_trig[track_pointer][1] = temp_first_8b[kk] + temp_second_8b[kk]*pow(2,8);	//Trigger code;
	track_pointer++;	
	}
	
	
}
	}
	
	//myfile1.close();
//myfile2.close();
	
	//cout << "Pointer length: " << track_pointer << "\n";	//Used for debugging;
	
	//Clear the memory
	delete [] trig_vect;
	/*
	cout << "Pointer length: " << track_pointer << "\n";
	cout << "Trigger: " << matrix_trig[0][0] << " - " << matrix_trig[0][1] << "\n";
	cout << "Trigger: " << matrix_trig[1][0] << " - " << matrix_trig[1][1] << "\n";
	cout << "Trigger: " << matrix_trig[2][0] << " - " << matrix_trig[2][1] << "\n";
	*/
	
	}
//*********************************************************************************************//

//*********************************************************************************************//
//Extract the EEG and the triggers
void read_bdf_data::read_data_bdf(FILE *file_data_f,int sf,int chan_n, int time_data){
	
	int temp_n_chan = chan_n - 1;
	int col_data = sf*bytes_data*time_data;
	uint8_t temp_data; 	//Variable to use to temporarly store a byte;
	int step_data; 
	 
	 //Dynamical allocation of the matrix used to store the data;
	matrix_data = new uint8_t *[temp_n_chan];
	 for (int count = 0; count < temp_n_chan; count++){
	 matrix_data[count] = new uint8_t [col_data];}
	 
	 //Dynamical allocation of the vector used to store the trigger;
	 vect_trig = new uint8_t [col_data];
	 
	 //for (int count = 0; count < temp_n_chan; count++){
	 //vect_trig[count] = new int [col_data];}
	 
//Start extracting the data		
	for (int kk = 1; kk < chan_n + 1; kk++){
	
	if (kk < chan_n){	//Extract the EEG data
	
fseek (file_data_f,(chan_n + 1)*256 + (kk - 1)*sf*bytes_data,SEEK_SET);	//Positioning the pointer to read the data for each channel
	//fseek (file_data,(chan_n + 1)*256 + (1 - 1)*sf*3,SEEK_SET);	//Positioning the pointer to read the data for each channel

cout << "Extracting Channel: " << kk << "\n";
//Looping through the data for the selected channel. Data are read every second.
step_data = 1;

  for (int count_samples = 0;(count_samples < sf*bytes_data*time_data && ((temp_data = fgetc(file_data_f)) != EOF)); count_samples++){
        
		matrix_data[kk-1][count_samples] = temp_data;//fgetc(file_data_f);
        
		if (count_samples == step_data*sf*bytes_data - 1){
			
			fseek (file_data_f,(chan_n + 1)*256 + (kk - 1)*sf*bytes_data + step_data*(chan_n)*sf*bytes_data,SEEK_SET);	//Skip the next second for each channel;
			step_data++;
			//cout << (chan_n + 1)*256 + (1 - 1)*sf*3 + (step_data - 1)*(chan_n - 1)*sf*3 << " - " << step_data - 1 << "\n";
		}
		
				} 
	
	}
	
	else{	//Extract the triggers saved in an addtional channel
		
		cout << "Extracting the trigger";
		fseek (file_data_f,(chan_n + 1)*256 + (kk - 1)*sf*bytes_data,SEEK_SET);
		
		step_data = 1;
		for (int count_samples = 0;(count_samples < sf*bytes_data*time_data && ((temp_data = fgetc(file_data_f)) != EOF)); count_samples++){
        
		vect_trig[count_samples] = temp_data;
        
		if (count_samples == step_data*sf*bytes_data - 1){
			
			fseek (file_data_f,(chan_n + 1)*256 + (kk - 1)*sf*bytes_data + step_data*(chan_n)*sf*bytes_data,SEEK_SET);	//Skip the next second for each channel;
			step_data++;
			
		}
		
				}
		
	}
	
	}
	
		 fclose(file_data_f);	//Close the file;

//for (int i = 29491200-11; i < 29491200; i++) {
//	for (int i = 0; i < 10; i++){
 //cout << "\n";
 //printf("%u ", matrix_data[1][i]);
//printf("%u ", vect_trig[i]);
//}

}
//*********************************************************************************************//
		

//*********************************************************************************************//
//Body of the main function		
    int main () {
  
  read_bdf_data rbd;
  
  const int length_data = 10000;	//This is an arbitrary number to ensure that the buffer is long enough to read the data  
int *buff_int = new int[length_data];	//Reads information saved as integer values;  
char * buff_char = new char [length_data];	//Reads information saved in ASCII format; 

string name_bdf;
char name_bdf_char[length_data];

cout << "\nType the name of the bdf file that you want to open: ";
getline (cin, name_bdf);

strcpy(name_bdf_char,name_bdf.c_str());	//Convert string to char. c_str() converts a C++ string into a C-style string which is essentially a null terminated array of bytes.

rbd.read_info_bdf(buff_char,buff_int,name_bdf_char);	//Read the information from the header file

if (s_data == -1)
{

        cout << "\nThe variable representing the 'Number of data record' was not read correctly and returned a value of -1. It is likely that the file is too big for the RAM and it cannot be opened on this computer. The operation has been aborted\n";

        return 0;

}
	    
if (!flag_invalid_name)
{

	rbd.read_data_bdf(file_data,srate,n_chan,s_data);	//Read the data

	rbd.read_data_complement_2(matrix_data,n_chan - 1,srate*s_data);

	rbd.read_triggers(vect_trig,srate*s_data);	//Now extract the latency and trigger code for each event;

	//system("pause"); 

}
//return 0;

}
