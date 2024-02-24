
input = "/Users/RSuzuki/Projects/cell_count_demo/imgs";  // doesnt work with relative path //TODO: change it to rel path
output = "/Users/RSuzuki/Projects/cell_count_demo/outs";
suffix = ".tif";

print(input);

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
    list = getFileList(input);
    list = Array.sort(list);
    print(list.length);

    for (i = 0; i < list.length; i++) {
        // if(File.isDirectory(input + File.separator + list[i])) {
        // processFolder(input + File.separator + list[i]);
        // }
        if(endsWith(list[i], suffix)) {
            processFile(input, output, list[i]);
        }
    }
}

function processFile(input, output, file) {
    // Do the processing here by adding your own code.
    // Leave the print statements until things work, then remove them.
    print("Processing: " + input + File.separator + file);
    print("Saving to: " + output);

    //opening the image
    open(input + File.separator + file);
}

