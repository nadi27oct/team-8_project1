
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding 500-yard freestyle swim times for male and female swimmers 
age 50-94 in a biennial national competition in 2009, 2011 and 2013. The 
research tries to find out if some improvements over the years for the swim 
completions, and have some insight if the further funding or investment for the 
swim clubs.
Dataset Name: SST091113_analytic_file created in external file
STAT6250-01_w17-team-8_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-8_project1_data_preparation.sas;
%let sasUEFilePrefix = team-8_project1;

* load external file that generates analytic dataset SST091113_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;
%macro setup;
%if
	&SYSSCP. = WIN
%then
	%do;
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup


*
Question: what is the average age of the group who attendence in these three years?
Rational:I used above coding to calculating the weight of each age and then calculation the average age.
Methodology:Use proc freq to calculation the frequency of each year and from that I can calculate the average age
;

proc freq data=sst091113_edited;
   tables Age;
run;


*
Title1
Footnote:by this step I can see the frequency of each year and this may help me to see the distribution of ages. 
Fotnote2: however this is for three years I may need to calculate it for each year also to see if the average increased?



*
question:compare the gender ratio of swimmers for 2009 and overall three years?
Rational:I wan to see if this report has a bias to one gender or not and also I want to see if at the first year we had
more women compare to the average of three years.
Methodology:Use proc freq. to have a percentage for all three years and also for 2009 I used the option firstobs to separate
2009
;

    proc freq data=sst091113_edited;
   tables Gender;   
    
run;

option firstobs=2 obs=200;
proc print data=sst091113_edited;
run;
proc freq data=sst091113_edited;
table Gender;
run;

* 
title 2
Footnot1: This step showing the ratio of gender in 2009 and compare it in total three years
Fotnote2: if one gander has a significat differant so the result has bias and we can not valiate it for miniority gender
*


*
Question: Is there any difference between Splits in their Min and Max?
Rational:I wanted to see if the time changing from first slipt to the last one and if the time increasing as they get tired.
Methodology: Use proc mean to calculating the min and max. time for each split and compare them together
;

proc means data=sst091113_edited min max maxdec=0;
   var Split_1 Split_2 Split_3 Split_4 Split_5 Split_6 Split_7 Split_8 Split_9 Split_10;
run;

*
Tite3
Footnote1:In this step I can see the Min. and Max. of each split to see if it is increasing by time or if they kept they energy for last split
Footnote2: this will clarify the hardest split for competitors
*







