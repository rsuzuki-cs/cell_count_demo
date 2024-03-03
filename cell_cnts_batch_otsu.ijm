input = getDirectory("Choose a Directory");
output = getDirectory("Choose a Directory");
suffix = ".tif";

cpds = newArray("emetine", "etoposide", "staurosporine");
cntrs1 = newArray("0.01", "0.03", "0.1", "0.3", "1.0", "3.0", "10.0", "30.0");
cntrs2 = newArray("0.0003", "0.001", "0.003", "0.01", "0.03", "0.1", "0.3", "1.0");

processFolder(input);

function processFolder(input) {
    for (i=0; i<cpds.length; i++) {
        File.makeDirectory(output + File.separator + cpds[i])
        if (cpds[i] == "staurosporine") {
            cntrs = cntrs2;
        } else {
            cntrs = cntrs1;
        }
        for (j=0; j<cntrs.length; j++) {
            ip = input + File.separator + cpds[i] + File.separator + cntrs[j];
            op = output + File.separator + cpds[i] + File.separator + cntrs[j];
            File.makeDirectory(op);
            list = getFileList(ip);
            list = Array.sort(list);
            for (k=0; k<list.length; k++) {
                if (endsWith(list[k], suffix)) {
                    processFile(ip, op, list[k]);
                }
            }
            print(cpds[i], cntrs[j], " done.");
        }
    }
}

function processFile(input, output, file) {

    //opening the image
    open(input + File.separator + file);

    filename_pure = File.nameWithoutExtension;
    saving_prefix = output + File.separator + filename_pure;

    //preparations
    roiManager("reset");
    run("Clear Results");
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");  //we remove the scaling

    //get the image name
    title = getTitle();

    run("Median...", "radius=10");
    setAutoThreshold("Otsu dark no-reset");
    setOption("BlackBackground", true);
    run("Convert to Mask");
    run("Watershed");
    run("Analyze Particles...", "  show=Overlay display exclude add");

    saveAs("results", saving_prefix + "_results.csv"); //use saveAs command to save results
    selectWindow(title);
    saveAs("tiff", saving_prefix + "_prcd.tif"); //use saveAs command to save an image

    //Clean-up
    run("Close All");

    print("Done.");
}

