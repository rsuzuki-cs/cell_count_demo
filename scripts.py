import cv2
import numpy as np
from skimage.segmentation import watershed
from skimage.filters import gaussian
import matplotlib.pyplot as plt
from skimage import measure

def cell_count_contour(image_path, mask_th, cnt_th, show_plot):
    # Read image
    img_orig = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    print(f"Original image dtype: {img_orig.dtype}")

    # Convert image to 8bit
    ## Process this even if the original image is already 8bit since it wouldn't change much.
    img_8bit = ((img_orig - img_orig.min()) / (img_orig.max() - img_orig.min())) * 255

    # Make masked image with a given threshold, smooth it gaussian filter
    masked_img = np.zeros(img_8bit.shape)
    masked_img[img_8bit > mask_th] = 255
    masked_img = gaussian(masked_img, sigma=5)

    # Find contour for a given intensity values
    contours = measure.find_contours(masked_img, level=cnt_th, fully_connected='high')
    print(f"Number of cells: {len(contours)}")

    # Plot
    if show_plot:
        # plt.hist(img_8bit.ravel(), bins=40); plt.title(f"Pixel value distribution of original image")
        # plt.show(); plt.close(); plt.cla(); plt.clf()

        # plt.figure(figsize=(5,10))
        fig, axes = plt.subplots(1,3, figsize=(10,5))
        axes[0].imshow(img_8bit, cmap="gray"); axes[0].set_title(f"Original image (8bit)")
        axes[1].imshow(masked_img, cmap="gray"); axes[1].set_title(f"Masked image")
        axes[2].imshow(masked_img, cmap="gray"); axes[2].set_title(f"Masked image with contours")
        for c in contours:
            axes[2].plot(c[:,1], c[:,0], c='b')
        plt.tight_layout(); plt.show(); plt.close(); plt.cla(); plt.clf()

        return len(contours), fig
    else:
        return len(contours)
