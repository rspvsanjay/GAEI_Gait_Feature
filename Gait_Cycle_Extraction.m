path1 = 'H:\Gait_IIT_BHU_Analysis\Silhouette_frames_Selected_big_blob_Extracted_Centered_Alinged_Directed_splitted_Alinged_Directed\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
save_path = 'H:\Gait_IIT_BHU_Analysis\Silhouette_frames_Selected_big_blob_Extracted_Centered_Alinged_Directed_splitted_Alinged_Directed_Half_Cycle\';
doubleSupport = 'H:\Occlusion_Analysis\TUM_IIT_KGP\double_support.png';
doubleSupportImage = double(imread(doubleSupport));
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
mid=double(0);
k=0;
path1
save_path
for f_no=31:y1
    path2=char(strcat(path1,fName1(f_no),'\'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=3:y2-4
        path3= char(strcat(path1,fName1(f_no),'\',fName2(ff_no),'\'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
%         fName2(ff_no)
        v=double([]);
        t=[];
        for fff_no = 3:y3
            image2=double(imread(char(strcat(path3,fName3(fff_no)))));
            r=corr2(doubleSupportImage,image2);
            v=[v,r];
            t=[t,fff_no-2];
        end
        [~,peakIndex1] = findpeaks(v);
%         figure,plot(t,v);
        v1 = smooth(v);
%         figure,plot(t,v,t,v1);
%         xlim([1 50]);
        [val1,peakIndex2] = findpeaks(v1);
        len1=[];
        for num1=1:length(peakIndex2)-1
            start1 = peakIndex2(num1);
            end1 = peakIndex2(num1+1);
            len1 = [len1,end1-start1];
        end
        [max1,index1] = max(len1);
        start1 = peakIndex2(index1);
        end1 = peakIndex2(index1+1);
        [~,index11] = min(abs(peakIndex1-start1));
        [~,index22] = min(abs(peakIndex1-end1));
        start1 = peakIndex1(index11);
        end1 = peakIndex1(index22);
        for fff_no = start1+2:end1+2
            image = imread(char(strcat(path3,fName3(fff_no))));
            if ~exist(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\')),'dir')
                mkdir(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no))));
            end
            imwrite(image,char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\',fName3(fff_no))));
        end
    end    
end