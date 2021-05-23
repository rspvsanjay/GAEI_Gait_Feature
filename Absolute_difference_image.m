path='H:\Gait_IIT_BHU_Analysis\Pose_Energy_Image\data\Normalized_Silhouette_frames\';
save_path='H:\Gait_IIT_BHU_Analysis\Pose_Energy_Image\data\Normalized_Silhouette_frames_Active_Image\';
list = dir(path);
fName = {list.name};
[~,y1]=size(fName);
path
tic;
for f_no=3:y1
     listin = dir(char(strcat(path,fName(f_no),'\')));
     fNamein = {listin.name};
     [~,y2]=size(fNamein);
     fName(f_no)
     for ff_no=3:y2
         listinin = dir(char(strcat(path,fName(f_no),'\',fNamein(ff_no),'\')));
         fNameinin = {listinin.name};
         [~,y3]=size(fNameinin);
         path2=char(strcat(path,fName(f_no),'\',fNamein(ff_no),'\'));
         sumimage=double(zeros(size(imread(char(strcat(path2,fNameinin(3)))))));
         for fff_no=3:y3-1
             image1 = imread(char(strcat(path2,fNameinin(fff_no))));
             if length(size(image1))==3
                 image1 = double(rgb2gray(image1));
             else
                 image1 = double(image1);
             end
             
             image2 = ((imread(char(strcat(path2,fNameinin(fff_no+1))))));
             if length(size(image2))==3
                 image2 = double(rgb2gray(image2));
             else
                 image2 = double(image2);
             end
             
             image = abs(image2 - image1);
             max1 = max(image(:));
             image = image/max1;
             if ~exist(char(strcat(save_path,fName(f_no),'\',fNamein(ff_no),'\')),'dir')
                 mkdir(char(strcat(save_path,fName(f_no),'\',fNamein(ff_no),'\')));
             end
             imwrite(image,char(strcat(save_path,fName(f_no),'\',fNamein(ff_no),'\',fNameinin(fff_no))));
         end      
     end
end
toc;