
File.openDialog("Select an image file");
input = File.directory + File.name;
outdir = getDirectory("Choose a Directory");

processFile(input, outdir);

function processFile(input, outdir) {

    //opening the image
    open(input);

    // set variables
    File.makeDirectory(outdir);
    fn = File.nameWithoutExtension;

    //preparations
    roiManager("reset");
    run("Clear Results");
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");  //we remove the scaling

    //get the image name
    title = getTitle();
    selectWindow(title);
    saveAs("tiff", outdir + File.separator + "raw_" + fn + ".tif"); //use saveAs command to save an image

    run("Median...", "radius=10");
    setAutoThreshold("Default dark no-reset");
    setOption("BlackBackground", true);
    run("Convert to Mask");
    run("Watershed");
    run("Analyze Particles...", "  show=Overlay display exclude add");

    saveAs("results", outdir + File.separator + fn + "_results.csv"); //use saveAs command to save results
    title = getTitle(); selectWindow(title);
    saveAs("tiff", outdir + File.separator + "segmented_" + fn + ".tif"); //use saveAs command to save an image

    //Clean-up
    // run("Close All");

    print("Done.");
}

