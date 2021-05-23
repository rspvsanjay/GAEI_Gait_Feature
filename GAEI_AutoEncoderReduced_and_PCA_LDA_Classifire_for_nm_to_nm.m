path1 = '/DATA/Sanjay/PLVEI/PLVEI_with_GEnI45/';
list1 = dir(path1);                       
fName1 = {list1.name};
[~,y1] = size(fName1);
path1
y1

cv111=[];
cv222=[];
cv333=[];
cv444=[];
cv555=[];
cv666=[];
cv777=[];
cv888=[];
cv999=[];
cv000=[];

pv111=[];
pv222=[];
pv333=[];
pv444=[];
pv555=[];
pv666=[];
pv777=[];
pv888=[];
pv999=[];
pv000=[];
% nm to nm where nm1 and nm2 considered as test case
for f_no=3:y1
    path2 = char(strcat(path1,fName1(f_no),'/'));
    list2 = dir(path2);                       
    fName2 = {list2.name};
    [~,y2] = size(fName2);
    fName1(f_no)
    y2
    numberOfPose=0;
    for ff_no=3:3
        path3 = char(strcat(path2,fName2(ff_no),'/'));
        list3 = dir(path3);                       
        fName3 = {list3.name};
        [~,y3] = size(fName3);
        numberOfPose = (y3-2)/10;        
    end    
    
    cv11=[];
    cv22=[];
    cv33=[];
    cv44=[];
    cv55=[];
    cv66=[];
    cv77=[];
    cv88=[];
    cv99=[];
    cv00=[];
    
    pv11=[];
    pv22=[];
    pv33=[];
    pv44=[];
    pv55=[];
    pv66=[];
    pv77=[];
    pv88=[];
    pv99=[];
    pv00=[];
    for num=1:numberOfPose       
        xTrainImages = double([]);
        xTestImages = double([]);
        tTrain=[];
        group1 = [];
        group2 = [];
        for ff_no=3:y2
            path3 = char(strcat(path2,fName2(ff_no),'/'));
            list3 = dir(path3);                       
            fName3 = {list3.name};
            [~,y3] = size(fName3);
            for fff_no=numberOfPose*6+2+(num):numberOfPose:y3
                group1 = [group1,(ff_no-2)];
                path4 = char(strcat(path3,fName3(fff_no)));                
                image = double(imread(path4));                
                max1 = max(image(:));
                image = image/max1;
                xTrainImages = [xTrainImages,image(:)];                
            end   
            
            for fff_no=numberOfPose*4+2+(num):numberOfPose:numberOfPose*6+2%y3
                group2 = [group2,(ff_no-2)];
                path4 = char(strcat(path3,fName3(fff_no)));
                image = double(imread(path4));
                max1 = max(image(:));
                image = image/max1;
                xTestImages = [xTestImages,image(:)];
            end
        end 
        
        [x1,y11] = size(xTrainImages);
        [x2,y22] = size(xTestImages);
        temp = [xTrainImages,xTestImages];
        size(temp)        
        rng('default');
        hiddenSize1 = 362;
        autoenc1 = trainAutoencoder(temp,hiddenSize1, ...
            'MaxEpochs',5, ...
            'L2WeightRegularization',0.004, ...
            'SparsityRegularization',4, ...
            'SparsityProportion',0.15, ...
            'ScaleData', false);
        feat1 = encode(autoenc1,temp);
        
        [xx,yy] = size(feat1);
        trainMat = double([]);
        testMat = double([]);
        for num1 = 1:y11
            trainMat = [trainMat,feat1(:,num1)];
        end
        for num1 = y11+1:yy
            testMat = [testMat,feat1(:,num1)];
        end
        train = trainMat';
        test = testMat';  
        
        [coeff,score,~,~,explained] = pca(train);
        sm = 0;
        no_components = 0;
        for k = 1:size(explained,1)
            sm = sm+explained(k);
            if sm <= 99.4029
                no_components= no_components+1;
            end
        end
        m = mean(train,1);
        mat1 = score(:,1:no_components);
        
        cv1=[];
        cv2=[];
        cv3=[];
        cv4=[];
        cv5=[];
        cv6=[];
        cv7=[];
        cv8=[];
        cv9=[];
        cv0=[];
        
        pv1=[];
        pv2=[];  
        pv3=[];
        pv4=[];
        pv5=[];
        pv6=[];
        pv7=[];
        pv8=[];
        pv9=[];
        pv0=[];
        num
        [a,b] = size(test);
%         a
%         b
        for number11=1:a
                Img_mean = double(test(number11,:))-m;
                Img_proj = Img_mean*coeff;
                test_features=Img_proj(:,1:no_components);
                [class,err,POSTERIOR] = classify(test_features,mat1,group1,'diaglinear');
                
                unique_cl = unique(group1);
                [max1,index] = max(POSTERIOR);               
                c = unique_cl(index);                
                cv1=[cv1;class];
                pv1=[pv1;max1];  
                
                POSTERIOR(index)=[];
                gp = unique_cl;
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv2=[cv2;gp(index)];
                pv2=[pv2;maxVal1];   
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv3=[cv3;gp(index)];
                pv3=[pv3;maxVal1];     
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv4=[cv4;gp(index)];
                pv4=[pv4;maxVal1];  
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv5=[cv5;gp(index)];
                pv5=[pv5;maxVal1];  
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv6=[cv6;gp(index)];
                pv6=[pv6;maxVal1];  
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv7=[cv7;gp(index)];
                pv7=[pv7;maxVal1];  
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv8=[cv8;gp(index)];
                pv8=[pv8;maxVal1];
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv9=[cv9;gp(index)];
                pv9=[pv9;maxVal1];  
                
                POSTERIOR(index)=[];
                gp(index) = [];
                [maxVal1,index] = max(POSTERIOR);
                cv0=[cv0;gp(index)];
                pv0=[pv0;maxVal1];                
        end      
        cv11=[cv11,cv1]; 
        cv22=[cv22,cv2];
        cv33=[cv33,cv3]; 
        cv44=[cv44,cv4];
        cv55=[cv55,cv5]; 
        cv66=[cv66,cv6];
        cv77=[cv77,cv7]; 
        cv88=[cv88,cv8];
        cv99=[cv99,cv9]; 
        cv00=[cv00,cv0];
        
        pv11=[pv11,pv1]; 
        pv22=[pv22,pv2];
        pv33=[pv33,pv3]; 
        pv44=[pv44,pv4];
        pv55=[pv55,pv5]; 
        pv66=[pv66,pv6];
        pv77=[pv77,pv7]; 
        pv88=[pv88,pv8];
        pv99=[pv99,pv9]; 
        pv00=[pv00,pv0];
    end
    cv111=[cv111,cv11];
    cv222=[cv222,cv22];
    cv333=[cv333,cv33]; 
    cv444=[cv444,cv44];
    cv555=[cv555,cv55];
    cv666=[cv666,cv66];
    cv777=[cv777,cv77];
    cv888=[cv888,cv88];
    cv999=[cv999,cv99];
    cv000=[cv000,cv00];
    
    pv111=[pv111,pv11];
    pv222=[pv222,pv22];
    pv333=[pv333,pv33]; 
    pv444=[pv444,pv44];
    pv555=[pv555,pv55];
    pv666=[pv666,pv66];
    pv777=[pv777,pv77];
    pv888=[pv888,pv88];
    pv999=[pv999,pv99];
    pv000=[pv000,pv00];
end


accu1 = [];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];

cv111 = [cv111,cv222];
pv111 = [pv111,pv222];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];

cv111 = [cv111,cv333];
pv111 = [pv111,pv333];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv444];
pv111 = [pv111,pv444];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv555];
pv111 = [pv111,pv555];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv666];
pv111 = [pv111,pv666];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv777];
pv111 = [pv111,pv777];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv888];
pv111 = [pv111,pv888];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv999];
pv111 = [pv111,pv999];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];


cv111 = [cv111,cv000];
pv111 = [pv111,pv000];
[num1,num2] = size(cv111);
accu=0;
for number=1:num1
    uclass=unique(cv111(number,:));
    p=[];
    for number1=1:length(uclass)
        sum1=0;
        for number2=1:length(cv111(number,:))
            if uclass(number1)==cv111(number,number2)
                sum1=sum1+pv111(number,number2);
            end
        end
        p=[p,sum1];
    end
    %figure,bar(uclass,p);
    [max1,index1] = max(p);
    c = uclass(index1);
    if c==group2(number)
        accu = accu+1;
    end        
end
path1
str="nm to nm where considered as test case"
ans1 = (accu/num1)*100;
ans1
accu1 = [accu1,ans1];
path='/DATA/Sanjay/PLVEI/PLVEI_with_GEnI45_CSV/';
csvwrite(char(strcat(path,'GEnI45_CASIA_nm_to_nmCV.csv')),cv111);
csvwrite(char(strcat(path,'GEnI45_CASIA_nm_to_nmPV.csv')),pv111);
csvwrite(char(strcat(path,'GEnI45_CASIA_nm_to_nm_Accu.csv')),accu1);