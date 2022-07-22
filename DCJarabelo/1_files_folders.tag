// *************
// By DCJarabelo
// https://gitlab.com/willowdans-research-and-development/rpa/tagui/file-and-folder-manipulation/-/blob/master/1_files_folders.tag
// *************
// slightly edited by lookang
quiet_mode = true

// list of files in the "in" folder as the flow file
list = get_files('./in/')
echo `list`

// if 'IN' folder is empty
if list.length == 0

    // additional line space
    echo
    echo 'IN' folder is empty

else 

    // additional line space
    echo    

    // showing the list of files after retrieving it
    // JavaScript array start from 0 for 1st element
    for n from 0 to list.length-1
        // echo `list[n]`
        echo Processing content of file '`list[n]`' ...
        load ./in/`list[n]` to content_var
        // echo `content_var`

        echo Moving '`list[n]`' to processed folder ...

        // using phantomjs
        // begin ======================================================================

        //var fs = require('fs');
        fs = require('fs');
        //var in_folder = "..\\flows\\dcj\\files_folder_manipulation\\in\\";
        //var in_folder = "..\\flows\\DCJarabelo\\in\\";
        // may need to change to absolute paths
        in_folder = "/Users/lookang/Desktop/tagui/flows/DCJarabelo/in/";
        //in_folder = "/in/";
        //var done_folder = "..\\flows\\dcj\\files_folder_manipulation\\done\\";
        done_folder = "/Users/lookang/Desktop/tagui/flows/DCJarabelo/done/";
        //done_folder = "/done/";
        fs.move(in_folder+list[n], done_folder+list[n]);

        // using phantomjs
        // end ======================================================================   

        echo Done moving '`list[n]`' to 'DONE' folder.

echo
echo ==============================
echo Autmation just ended here ... 
echo ==============================