clc;
clear;

root_listing_ann=dir('/media/TOSHIBA EXT/ILSVRC2015 (2)/Annotations/VID/val');

num_videos_ann=numel(root_listing_ann)-2;


% for i=1:num_videos_ann
for i=1:8
    
ann_name=root_listing_ann(i+2).name;

str_ann='/media/TOSHIBA EXT/ILSVRC2015 (2)/Annotations/VID/val';

full_ann_name=fullfile(str_ann,ann_name);

listing2=dir(full_ann_name);

num_xml=numel(listing2)-2;


mkdir('/media/TOSHIBA EXT/ILSVRC2015 (2)/Data/VID/gt_boxes',ann_name);
folder_save_ann=fullfile('/media/TOSHIBA EXT/ILSVRC2015 (2)/Data/VID/gt_boxes',ann_name);
cd(folder_save_ann);

for i=1:num_xml

    xml_name=listing2(i+2).name;
    
    str2=fullfile('/media/TOSHIBA EXT/ILSVRC2015 (2)/Annotations/VID/val',ann_name);
    
    xml_full_name=fullfile(str2,xml_name);
    
xml_file=xml_read(xml_full_name);

%有的annotation不存在object!
if_exist_object=isfield(xml_file,'object');
temp=zeros(0,0);

if (if_exist_object==1)
num_gt_box=numel(xml_file.object);

for i=1:num_gt_box
    
temp(i,1)=xml_file.object(i).bndbox.xmax;
temp(i,2)=xml_file.object(i).bndbox.xmin;
temp(i,3)=xml_file.object(i).bndbox.ymax;
temp(i,4)=xml_file.object(i).bndbox.ymin;

end
end 

pic_width=xml_file.size.width;
pic_height=xml_file.size.height;
add_row=[pic_height,0,pic_width,0];
temp=[temp;add_row];

gt_and_pic_boxes_name=strcat(xml_name(1:end-4),'.mat');
save(gt_and_pic_boxes_name,'temp');

clear xml_file;
end
end