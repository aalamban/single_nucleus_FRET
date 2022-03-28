data_dir = "/home/aydoganlab/Documents/Andrew/cyclinB(m)_cdk1-fret/data/20220117_series9/";
out_dir = "/home/aydoganlab/Documents/Andrew/cyclinB(m)_cdk1-fret/outputs/20220117_series9/mips/";
list = getFileList(data_dir);
for(i=0; i<lengthOf(list);i++){
	print("test_1");
	filename = list[i];
	print(data_dir + filename);
	open(data_dir + filename);
	shorter_name = substring(filename, 0, lengthOf(filename) - 4);
	print(shorter_name);
	selectWindow(shorter_name + ".tif");
	run("Z Project...", "projection=[Max Intensity]");
	selectWindow(shorter_name + ".tif");
	close();
	for(j=0; j<5;j++){
		if (j!=0){
			print("Processing Channel =" + toString(j));
			shorter_name = substring(filename, 0, lengthOf(filename) - 4);
			selectWindow("MAX_" + shorter_name + ".tif");
			run("Duplicate...", "duplicate channels=" + toString(j));
			selectWindow("MAX_" + shorter_name + "-1.tif");
			run("Subtract Background...", "rolling=50");
			run("Enhance Contrast...", "saturated=0.3 normalize equalize");
			run("Smooth");
			saveAs("Tiff", out_dir + shorter_name + "_ch" + toString(j) + ".tif");
			close();
		}
	}
	selectWindow("MAX_" + shorter_name + ".tif");
	close();
}





