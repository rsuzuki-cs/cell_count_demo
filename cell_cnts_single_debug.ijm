
input = "/Users/RSuzuki/Projects/cell_count_demo/imgs/DAPI/staurosporine/0.3/Week3_290607_C04_s1_w15AC4BDFC-6844-43BF-81EB-1BB486D869C2.tif";  // doesnt work with relative path //TODO: change it to rel path
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

    // //get the image name
    // title = getTitle();
    // selectWindow(title);
    // saveAs("tiff", outdir + File.separator + "raw_" + fn + ".tif"); //use saveAs command to save an image

    // run("16-bit");
    // run("8-bit");
    run("Median...", "radius=10");
    // setAutoThreshold("Default dark no-reset");
    setAutoThreshold("Otsu dark no-reset");
    setOption("BlackBackground", true);
    run("Convert to Mask");
    run("Watershed");
    run("Analyze Particles...", "  show=Overlay display exclude add");

    // saveAs("results", outdir + File.separator + fn + "_results.csv"); //use saveAs command to save results
    // title = getTitle(); selectWindow(title);
    // saveAs("tiff", outdir + File.separator + "segmented_" + fn + ".tif"); //use saveAs command to save an image

    // //Clean-up
    // // run("Close All");

    print("Done.");
}

