
input = "/Users/RSuzuki/Projects/cell_count_demo/imgs/DAPI/emetine/0.01/Week3_290607_C10_s2_w14A4A3A02-57AA-4A68-B11C-ED3364ACC653.tif";  // doesnt work with relative path //TODO: change it to rel path
outdir = "/Users/RSuzuki/Projects/cell_count_demo/outs/single";
suffix = ".tif";

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

