###Welcome to the OFET Database GitHub Repository!
Any use of this repository for research purposes must legally cite the paper in which it was introduced.

# Exploring the Database Online
### OFET Database is viewable as a table with interactive filtering and sorting!
[Explore the Database](http://nbviewer.jupyter.org/github/Imperssonator/OFET-Database/blob/master/OpenOFET.ipynb)

## Exploring the Database via GUI
[Download](https://github.com/Imperssonator/OFET-Database/archive/master.zip) the repository to your MatLab active directory. (See "Download ZIP" at top right of [repository main page](https://github.com/Imperssonator/OFET-Database)).

Run the following command:

OFET_GUI()

Or simply right click on the file "OFET_GUI.m" and select "Run".
A window will pop up from which you can select process constraints and generate plots of mobility against many different independent variables. Minor bugs may be encountered - close the GUI and restart it to reset all fields.

## Exploring the Database as Raw Data
[Download](https://github.com/Imperssonator/OFET-Database/archive/master.zip) the repository to your MatLab active directory. (See "Download ZIP" at top right of [repository main page](https://github.com/Imperssonator/OFET-Database)).

Run the following command:

load('Functions/OFETDatabase.mat')

The Database should now exist as a structure array called "OFET" in your workspace. Open it in the variable explorer to interact with the raw data.

## View individual papers as Excel sheets
[Download](https://github.com/Imperssonator/OFET-Database/archive/master.zip) the repository to your MatLab active directory. (See "Download ZIP" at top right of [repository main page](https://github.com/Imperssonator/OFET-Database)).

Open the "Papers" folder, then open the folder for any author, and open the .xlsx file for that paper.
