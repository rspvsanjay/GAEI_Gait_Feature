path1='/DATA/Sanjay/PLVEI_TUMGAID/Depth_Cropped_Fliped_Renamed_BinaryImageShifted_Fliped_alignment_half_cycle/';
save_path='/DATA/Sanjay/PLVEI_TUMGAID/Depth_Cropped_Fliped_alignment_half_cycle_DistortionRate/';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
path1
save_path
y1
% doubleSupport = 'C:\Data\For new Paper3\TUM_GAID_Gait_Analysis\DoubleSupportImage1.png';
% image8 = imread(doubleSupport);
for f_no=55:y1
    path2=char(strcat(path1,fName1(f_no),'/'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=7:y2
        path3= char(strcat(path1,fName1(f_no),'/',fName2(ff_no),'/'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        clustNum = numberOfClusters(path3);
        clustNum
        if clustNum<=(y3-2)
            clustNum=round(clustNum/2);
        end
%         clustNum =3;
        slot = round((y3-2)/clustNum);
        if slot*3<(y3-2)
            slot=slot+1;
        end
        pose = double(zeros(200,200));
        count = 0;
        poseNum = 0;
        fr=0;
        for fff_no = 3:y3
            image2=double(imread(char(strcat(path3,fName3(fff_no)))));
            count=count+1;
            pose = pose+image2;
            if count==slot
                count = 0;
                fr=fff_no;
                poseNum = poseNum+1;
                pose = pose/slot;
                max1 = max(pose(:));
                pose = pose/max1;
                if ~exist(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/')),'dir')
                    mkdir(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/')));
                end
                if poseNum<10
                    imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose000',int2str(poseNum),'.png')));
                elseif poseNum<100
                    imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose00',int2str(poseNum),'.png')));
                elseif poseNum<1000
                    imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose0',int2str(poseNum),'.png')));
                elseif poseNum<10000
                    imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose',int2str(poseNum),'.png')));
                end
                pose = double(zeros(200,200));
            end
        end
        if fr<y3
            for fff_no = y3-slot+1:y3
                image2=double(imread(char(strcat(path3,fName3(fff_no)))));
                pose = pose+image2;
            end
            poseNum = poseNum+1;
            pose = pose/slot;
            max1 = max(pose(:));
            pose = pose/max1;
            if poseNum<10
                imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose000',int2str(poseNum),'.png')));
            elseif poseNum<100
                imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose00',int2str(poseNum),'.png')));
            elseif poseNum<1000
                imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose0',int2str(poseNum),'.png')));
            elseif poseNum<10000
                imwrite(pose,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/pose',int2str(poseNum),'.png')));
            end
        end
    end
end

function y = numberOfClusters(path3)
list3 = dir(path3);
fName3 = {list3.name};
[~,y3]=size(fName3);
distortionRate = [];
numberOfCluster = [];
for div1=1:(y3-2)
    slot = round((y3-2)/div1); %slot tell us number of frames within a cluster
    sum1 = double(0);
    for number1=1:div1
        sumImage = double(zeros(200,200));
        for number2=3:(slot+2)
            if((number2+(number1-1)*slot)<=y3)
                img = im2double(imread(char(strcat(path3,fName3(number2+(number1-1)*slot)))));
                sumImage = sumImage + img;
            end
        end
        sumImage = sumImage/slot;
        %         figure,imshow(sumImage,[]);
        for number2=3:(slot+2)
            if((number2+(number1-1)*slot)<=y3)
                img = im2double(imread(char(strcat(path3,fName3(number2+(number1-1)*slot)))));
                sum1 = sum1+pdist2(img(:)',sumImage(:)');%max(temp(:));%pdist2(img(:)',sumImage(:)');%norm(img(:)-sumImage(:), 2);%corr2(sumImage,img);
            end
        end
    end
    distortionRate = [distortionRate,sum1];
    numberOfCluster = [numberOfCluster,div1];
end
% distortionRate
% numberOfCluster
% peakIndex2peakIndex2 = 1-distortionRate;
[val1,peakIndex2] = findpeaks(distortionRate);
y=peakIndex2(length(peakIndex2));
end