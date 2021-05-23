path = 'H:\Gait_IIT_BHU_Analysis\Pose_Energy_Image\Refernced_Half_Gait_Cycle_16/';
list = dir(path);
fName = {list.name};
[~,y]=size(fName);
poses = cell(0,0);
for pose_no=3:y
    poses{pose_no-2}=double(imresize(imread(char(strcat(path,fName(pose_no)))),[256 256]));
%     poses{pose_no-2}=double(imread(char(strcat(path,fName(pose_no)))));
end
path1 = 'H:\Gait_IIT_BHU_Analysis\Pose_Energy_Image\Normalized_Silhouette_frames\';
save_path='H:\Gait_IIT_BHU_Analysis\Pose_Energy_Image\Normalized_Silhouette_frames_PEI\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
save_path
for f_no=3:y1
    path2=char(strcat(path1,fName1(f_no),'\'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=3:y2
        path3= char(strcat(path2,fName2(ff_no),'\'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        v = cell(y-2,y3-2);
        for pose_num=1:y-2
            for fff_no=3:y3
                image=double(imread(char(strcat(path3,fName3(fff_no)))));
                r=corr2(poses{pose_num},image);
                v{pose_num}=[v{pose_num},r];
            end
        end
        mat1 = double([]);
        for pose_num=1:y-2
            mat1 = [mat1,v{pose_num}];
        end
        mat2 = (1-mat1);
        fourthofNodes = length(mat2)/(y-2);
        s=[];
        t=[1];
        for num=1:(y-2)
            s=[s,length(mat2)+2];%s is vector of elements, connectivity start from
        end
        for num=1:(y-3)
            t=[t,fourthofNodes*num+1]; % t target vector respect to vector s correspondings
        end
        for num=1:length(mat2)
            if mod(num,fourthofNodes)~=0
                s=[s,num,num];
                if num<=fourthofNodes*(y-3)
                    t=[t,num+1,num+fourthofNodes+1];
                else
                    t=[t,num+1,mod(num+fourthofNodes,length(mat2))+1];
                end
            end
        end
        %         [a,b]=size(mat2);
        weights = [];
        for num=1:length(t)
            weights = [weights,mat2(t(num))];
        end
        for num=1:(y-2)
            s=[s,fourthofNodes*num];%s is vector of elements, connectivity start from
        end
        for num=1:(y-2)
            t=[t,length(mat2)+1]; % t target vector respect to vector s correspondings
            weights = [weights,0.99];
        end
        weights(isnan(weights))=0;
        G = digraph(s,t,weights);
        
        %             figure,plot(G,'EdgeLabel',G.Edges.Weight);
        [p,d] = shortestpath(G,length(mat2)+2,length(mat2)+1);
        
        poseNumber=[];
        frameNumber=[];
        for num=1:fourthofNodes
            frameNumber = [frameNumber,num];
        end
        for num=2:length(p)-1
            if int16(p(num)/fourthofNodes)<(p(num)/fourthofNodes)
                poseNumber = [poseNumber,int16(p(num)/fourthofNodes)+1];
                %                 frameNumber = [frameNumber,((p(num)/fourthofNodes)-double(int16(p(num)/fourthofNodes)))*fourthofNodes];
            end
            if int16(p(num)/fourthofNodes)>(p(num)/fourthofNodes)
                poseNumber = [poseNumber,int16(p(num)/fourthofNodes)];
                %                 frameNumber = [frameNumber,double(int16(p(num)/fourthofNodes)-(p(num)/fourthofNodes))*fourthofNodes];
            end
            if int16(p(num)/fourthofNodes)==(p(num)/fourthofNodes)
                poseNumber = [poseNumber,int16(p(num)/fourthofNodes)];
                %                 frameNumber = [frameNumber,int16(p(num)/fourthofNodes)*fourthofNodes];
            end
        end
        
        pei = cell(y-2,0);
        for num=1:y-2
            pei{num} = double(zeros(size(poses{1})));
        end
        
        for pose_num=1:y-2
            for num=1:length(frameNumber)
                if poseNumber(num)==pose_num
                    image = double(imread(char(strcat(path3,fName3(frameNumber(num)+2)))));
                    %                     img_dilate = imdilate(image,se);
                    %                     bdry_img = img_dilate-image;
                    %                     pei{pose_num} = pei{pose_num} + bdry_img;
                    
                    pei{pose_num} = pei{pose_num}+image;%pei{pose_num} + bdry_img;
                end
            end
            max1=max(pei{pose_num}(:));
            pei{pose_num}=pei{pose_num}/max1;
        end
        
        if ~exist(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\')),'dir')
            mkdir(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\')));
        end
        for num = 1:y-2
            max1 = max(pei{num}(:));
            pei{num} = pei{num}/max1;
            if num<10
                imwrite(pei{num},char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'/pose0',int2str(num),'.png')));
            else
                imwrite(pei{num},char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'/pose',int2str(num),'.png')));
            end
        end
        
%         if ~exist(char(strcat(save_path,fName1(f_no),'\')),'dir')
%             mkdir(char(strcat(save_path,fName1(f_no),'\')));
%         end
%         for pose_num=1:y-2
%             if pose_num<10
%                 imwrite(pei{pose_num},char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),int2str(pose_num),'.png')));
%             else
%                 imwrite(pei{pose_num},char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),int2str(pose_num),'.png')));
%             end
%         end
    end
end