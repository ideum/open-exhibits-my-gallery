# open-exhibits-my-gallery

My Gallery 対話型 (Interactive) is a fully functional interface that allows users to experience the museum curatorial process first-hand by creating their own galleries. Users can touch a photograph, enlarge or shrink it, select their favorite photographs to create a gallery and then title the collection in English or Japanese.

This interface was developed by the Museum of Photographic Arts (MOPA), the National Institute of Information and Communications Technology (NICT), and the Pacific Rim Undergraduate Experience(PRIME) program at the University of California, San Diego (UCSD).

VIDEO
- https://vimeo.com/34926727

Program Instructions:

1. When you start the program you will be shown the credit screen and then you will see a button that says “Begin”. Click the button to get to the main screen.
2. On the main screen you will see a scroller to the left and “My Gallery” to the right. You can drag the images in the scroller up and down to scroll. In order to select and image to view, you must drag an image from the scroller to the right and place it into the central viewing area. You can place up to ten images in the central viewing area.
3. When the images are placed into the viewing area, they turn into display objects. Each display object has three buttons. The “X” button closes the image and puts it back in the scroller, the “+” button adds the image to “My Gallery”, and the “i” button opens and closes the information display. You can drag the display objects and you can zoom in and zoom out by using the zoom gestures. You can drag the display object into the “My Gallery” area to add it to your collection or you can drag it into the scroller area to place it back in the scroller.
4. Once the display object is dragged into the “My Gallery” area it will show up in your collection of images. In order to remove images from you collection, you can drag them from the “My Gallery” area back into the scroller area or back into the central viewing area. You can also drag the images into the trash can button or just click it. Dragging the image into the trash can button will place it back into the scroller area.
5. The “Clear Workspace” button on the main screen does just that, it clears the workspace.
6. The “Start Over” button will reset the program and take you back to the credit screen.
7. The “About My Gallery Interactive” button will bring up a popup that tells you about the program. Click the popup to close it.
8. Once you have selected the images you like and they are all contained in the “My Gallery” area, then you can click the “My Gallery” button and it will take you to the gallery screen.
9. On the gallery screen you can drag the images to reorder them. Once the images are in the order you like, click either of the input boxes below the images to bring up the software keyboard. The keyboard starts out in English and there is a button to the bottom left to change it to Japanese. Use the keyboard to enter the title of your gallery and to enter your name. Then click the “Submit Gallery” button to save your collection. If you would like to re-order the images before saving, you can click outside of the keyboard area to move the collection back into view. Once the “Submit Gallery” button has been pressed, you will be taken back to the main screen. If you wish to get back to the main screen without saving your collection, press the “Mopa Collection” button on the gallery screen.
10. Once you have saved your collection, you can view it and others by clicking the “Saved Galleries” button on the main screen.
11. On the saved galleries screen you can click the up and down buttons to scroll through the saved collections. You can sort the collections by name, time created, or title by clicking the respective buttons. To select a collection to view, click it.
12. When you click a collection, you will be taken to the collection viewing screen. You can click any of the images on this screen to view it as a display object. You can do interact with the display object as I have described before, the only thing you cannot do is click the “+” button since you are not on the main screen. Click the “X” button to send the photo back to the collection area. if you want to make room for others. To get back to the saved galleries screen, you must click the arrow button to the bottom left of the screen.

Special Program Instructions/ FYI:

1. You cannot click the “Saved Galleries” button until you have saved a collection first. We did not test for click the “Saved Galleries” button when the program first starts, but apparently it will not work properly unless you have first saved a collection. This is fixable.
2. The program was designed for single person use, so it may freeze when multiple people are using it at the same time.
3. 
Operating Instructions:

1. In order to save user collections, you must download a PHP server and run it locally. There is a file called collection.php in the main folder that you will need to run on the server. I used a program called WAMP in order to accomplish this.
2. WAMP Instructions: Download WAMP from their website and follow the instructions for installing it in the default location, which is the C: drive. Once it is installed you will need to go to start it by going to the WampServer folder in All Programs and clicking on “start WampServer”. You will need to place the collection.php file I mentioned earlier in the “www” folder of the wamp server so that it can be accessed when My Gallery Interactive initiates an HTTP request. The “www” folder can be found in the C: folder under C:wampwww if you installed WAMP with the default settings. Once collection.php is placed in the “www” folder, then the program should be able to communicate with it and save collections properly as long as the server is on and running. You can tell that the server is on and running when you see a green “W” icon in your task bar to the bottom right where all the background program icons are. **If you chose to install the WAMP server in a location other than the default location, then you must edit the PersonalCollectionSaver.as file to notify the program of the new location of collection.php. You need to edit line 12 where the URLRequest method is. After you edit it you must republish the program in Flash Professional.**
3. My Gallery Interactive needs three sizes of the same image for efficiency and speed. If you wish to use your own collection of images instead of the ones that came with the program, you must empty out the “images”, “bigthumbs”, and “thumbs” folders and add your images to them. **The program was tested for 50 images so if you wish to use a different amount, you must use two or more and the total amount of images must be even since they will be split into two columns. I cannot guarantee that the program will work with a different amount of images, since it was never tested.** The image folders should be located in the main folder. The “images” folder should contain the original size images in your collection, and they cannot be bigger than 4000×4000 pixels. The “bigthumbs” folder should contain your image collection, but the pictures should be around 600×600 pixels in size, no bigger. The “thumbs” folder should contain your image collection, but the pictures should be around 300×300 pixels in size, no bigger. Once you’ve added your images in all three sizes, you must edit the Exbitlist.xml file located in the main folder.
4. The ExhibitList.xml file contains all the metadata about the images in your collection. Each entry under the “Content” tag tells you about each image including where it is located on your computer. The ExhibitList.xml file contains comments so you can better understand what it does. You need to change each “Source” in the “Content” tag to reflect your new collection’s information. Also, if you change the size of the collection you must make sure to add or delete “Source” tags to accommodate for that new collection. The program uses 50 images by default, so there are 50 “Source” tags. Each “Source” tag has an id that also must be noted if you choose to use more than 50 images.
5. ExhibitList.xml also contains a tag called “Global Settings”. The most important setting in there is the location of the SavedCollections.xml file. You will need to change the “outputfile” tag to reflect the location of SavedCollections.xml on your computer.
6. The SavedCollections.xml file has a couple of curated collections with descriptions created by Vivian Kung Haga, the deputy director at the Museum of Photographic Arts. **If you delete entries in the file in order to save new collections, then you must make sure that there is at least one collection saved in the file before the program tries to save new ones to it. Otherwise, the program will not work or it will crash. I recommend leaving one curated collection in the file as an example for others.**
7. Finally, there is the application.xml file. It supports “Flosc” and “Native” input protocols. The program uses “Native” input by default, but you can change it to “Flosc” if that is how your multi-touch device communicates. All you need to do is change the “InputProvider” tag.

Caveats:

- The program was developed on two different windows laptops. For some reason, when I compile the program on my laptop, the images don’t center properly on the gallery screen. If you find that the images don’t center properly for you as well, then you may be able to fix it by re-publishing the entire project.

This concludes the instructions for using My Gallery Interactive. If you have any questions, please post them on the forum or open up an issue.

If have questions about this software, check the [Open Exhibits Software Support Forum](http://openexhibits.org/community/groups/oe-software-support/forum/) to submit inquiries to, and find answers from OE community members.

Note: This Exhibit/Template requires Open Exhibits SDK 1.2.

SUPPORTED OPERATING SYSTEMS
- Windows 7
- Windows 8
- Mac OS X
- 
ASSOCIATED LANGUAGES
- ActionScript 3

Author: Lance Castillo
