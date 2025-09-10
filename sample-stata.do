
if "`c(username)'"== "abc" {
    global root   "/Users/abc/Dropbox/Project"
	global R_dir "C:\Program Files\R\R-4.4.3\bin\x64" // needed to run data construction!
}

global data_work "$rootdir"
global R_dir "/usr/bin/R"


** Data Construction

* Data

	*raw data raw	
	global raw "$data_work/Data_Construction/Data/raw"
		global raw_ff "$raw/Followup"
	*final data 
	global data_f "$data_work/Data_Construction/Data/final"
		global final_f "$data_f/followup"
	*trash
	global trash "$data_work/Data_Construction/Data/trash"
		global trash_ff "$trash"
		global trash_f "$trash"
		
	* for replication
	global for_replication "$data_work/Data_Construction/Data/for_replication"

*Codes
	    global do "$data_work/Data_Construction/Codes/Baseline"
		global do_ff "$data_work/Data_Construction/Codes/Field work/Followup"
		global do_f "$data_work/Data_Construction/Codes/Feedback_treatment"
		global code_R "$data_work/Data_Construction/Codes/Students"