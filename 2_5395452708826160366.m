function mainGUI
    % النافذة الرئيسية
    fig = uifigure('Name', 'الواجهة الرئيسية', 'Position', [200 100 800 500]);

    % === عرض صورة خلفية ===
    ax = uiaxes(fig, 'Position', [0 0 800 500]);
    try
        img = imread('C:\Users\NS\Desktop\AI-Powered-Medical-Imaging-Solutions-for-Advanced-Healthcare-1-1024x683.jpg');
        imshow(img, 'Parent', ax);
    catch
        warning('تعذر تحميل الصورة، تأكد من صحة المسار.');
    end
    ax.Visible = 'off';  % إخفاء الإحداثيات

    % تشغيل مؤقت بعد 5 ثواني لفتح واجهة الأزرار
    t = timer('StartDelay', 5, 'TimerFcn', @(~,~) openButtonPanel());
    start(t);
end

function openButtonPanel()
    fig = uifigure('Name', 'الواجهة التالية', 'Position', [300 200 400 200]);

    uilabel(fig, 'Text', 'اختر العملية:', ...
        'FontSize', 16, 'FontWeight', 'bold', ...
        'Position', [130 140 200 30]);

    uibutton(fig, 'Text', 'عملية التحسين', ...
        'Position', [50 70 130 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) openEnhancementGUI());

    uibutton(fig, 'Text', 'عملية التصنيف', ...
        'Position', [220 70 130 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) openClassificationGUI());
     
end
function openEnhancementGUI()
    fig = uifigure('Name', 'واجهة تحسين الصور', 'Position', [350 250 800 500]);

    uilabel(fig, 'Text', 'اختر طريقة التحسين:', ...
        'Position', [50 440 200 30], 'FontSize', 14, 'FontWeight', 'bold');

    methodList =  {'HE', 'AHE', 'CLAHE', 'BI-HE', 'HE-BW', 'AHE-BW', 'BI-HE-BW', 'CLAHE-BW'};
    methodDropdown = uidropdown(fig, 'Items', methodList, 'Position', [200 440 200 30], 'FontSize', 14);

    ax1 = uiaxes(fig, 'Position', [50 60 300 300]);
    title(ax1, 'الصورة الأصلية');

    ax2 = uiaxes(fig, 'Position', [400 60 300 300]);
    title(ax2, 'الصورة المحسنة');

    uibutton(fig, 'Text', 'تشغيل المعالجة', 'Position', [420 440 140 30], 'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) applyEnhancement(methodDropdown.Value, ax1, ax2));
end


function openClassificationGUI()
    fig = uifigure('Name', 'واجهة التصنيف', 'Position', [150 150 600 400]);

    % زر بيانات محلية
    uibutton(fig, 'Text', 'بيانات محلية', ...
        'Position', [50 300 150 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) msgbox('اختر من القائمة المنسدلة بيانات محلية', 'بيانات محلية'));

    % القائمة المنسدلة لبيانات محلية
    uidropdown(fig, ...
        'Items', {'CT lowcontrast', 'CT', 'MRI lowcontrast', 'MRI'}, ...
        'Position', [220 305 250 30], ...
        'FontSize', 14, ...
        'ValueChangedFcn', @(dd,event) handleLocalSelection(dd.Value));

    % زر بيانات عالمية
    uibutton(fig, 'Text', 'بيانات عالمية', ...
        'Position', [50 220 150 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) msgbox('اختر من القائمة المنسدلة بيانات عالمية', 'بيانات عالمية'));

    % القائمة المنسدلة لبيانات عالمية
    uidropdown(fig, ...
        'Items', {'X-RAY lowcontrast', 'X-RAY', 'MRI lowcontrast', 'MRI', 'ULTRASOUND lowcontrast', 'ULTRASOUND'}, ...
        'Position', [220 225 250 30], ...
        'FontSize', 14, ...
        'ValueChangedFcn', @(dd,event) msgbox(['تم اختيار: ' dd.Value], 'بيانات عالمية'));

    % دالة الربط باختيارات بيانات محلية
    function handleLocalSelection(selectedValue)
        switch selectedValue
            case 'CT lowcontrast'
                disp('✅ تشغيل نموذج CT منخفض التباين...');
                multihybrid();

            case 'CT'
                msgbox('يرجى تزويدي بدالة CT العادية إذا كنت تريد ربطها.');

            case 'MRI'
                disp('✅ تشغيل نموذج MRI...');
                runmultihybrid();

            case 'MRI lowcontrast'
                msgbox('يرجى تزويدي بدالة MRI منخفض التباين.');

            otherwise
                msgbox(['تم اختيار: ' selectedValue], 'معلومة');
        end
    end
end
function showEnhancedImages(methodName)
    input_folder ="C:\Users\NS\Desktop\New folder (4)\New folder\New folder\New folder (2)";
    output_folder = "C:\Users\NS\Desktop\New folder (4)\New folder\New folder\7";

    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end

    image_files = dir(fullfile(input_folder, '*.jpg'));

    for i = 1:length(image_files)
        img = imread(fullfile(input_folder, image_files(i).name));

        if size(img, 3) == 3
            img_gray = rgb2gray(img);
        else
            img_gray = img;
        end

        img_denoised = medfilt2(img_gray, [3 3]);

        img_clahe = adapthisteq(img_denoised, 'ClipLimit', 0.04, 'NumTiles', [8 8]);

        img_smoothed = imgaussfilt(img_clahe, 0.8);

        [M, N] = size(img_smoothed);
        D0 = 70;   % تردد مركزي
        W = 50;    % عرض النطاق
        n = 6;     % الرتبة

        [u, v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
        D = sqrt(u.^2 + v.^2);
        H = 1 ./ (1 + ((D.*W) ./ (D.^2 - D0^2)).^(2*n));

        F = fftshift(fft2(double(img_smoothed)));
        G = H .* F;
        img_filtered = real(ifft2(ifftshift(G)));

        img_filtered = mat2gray(img_filtered);

        sharpened_img = imsharpen(img_filtered, 'Amount',6, 'Radius', 2);

        output_filename = fullfile(output_folder, ['processed_', image_files(i).name]);
        imwrite(sharpened_img, output_filename);

        figure('Name', sprintf('الصورة %d - %s', i, image_files(i).name), 'NumberTitle', 'off');
        subplot(1,2,1);
        imshow(img_gray);
        title('الصورة الأصلية');

        subplot(1,2,2);
        imshow(sharpened_img);
        title('الصورة المحسنة');

        pause(1);

        fprintf('✅ تم معالجة وحفظ: %s\n', output_filename);
    end

    disp('🎯 تمت معالجة جميع الصور بنجاح.');
end

function runHE_BW()
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif','صور (*.jpg,*.png,*.bmp,*.tif)'}, 'اختر صورة');

    if isequal(filename,0) || isequal(pathname,0)
        disp('لم يتم اختيار صورة.');
        return;
    end
    img_path = fullfile(pathname, filename);
    img = imread(img_path);

    if size(img,3) == 3
        img = rgb2gray(img);
    end

    HE_img = histeq(img);

    % تأكد أن دالة butterworthbpf موجودة
    filtered_image = butterworthbpf(double(HE_img), 20, 120, 4);

    filtered_image_uint8 = uint8(mat2gray(filtered_image)*255);

    figure;
    subplot(1,2,1);
    imshow(img);
    title('الصورة الأصلية');

    subplot(1,2,2);
    imshow(filtered_image_uint8);
    title('الصورة بعد HE + Butterworth');

    output_folder = 'Enhanced withBW';
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
    [~, name, ~] = fileparts(filename);
    imwrite(filtered_image_uint8, fullfile(output_folder, [name, '_HE_BW.png']));

    disp(['تم حفظ الصورة المحسنة في: ', fullfile(output_folder, [name, '_HE_BW.png'])]);
end
function applyEnhancement(method, ax1, ax2)
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif','صور (*.jpg,*.png,*.bmp,*.tif)'}, 'اختر صورة');

    if isequal(filename,0)
        disp('❌ لم يتم اختيار صورة.');
        return;
    end

    img_path = fullfile(pathname, filename);
    img = imread(img_path);
    original_img = img;

    if size(img,3) == 3
        img = rgb2gray(img);
    end

    switch method
        case 'HE'
            result = histeq(img);

        case 'AHE'
            result = adapthisteq(img);

        case 'CLAHE'
            result = adapthisteq(img, 'ClipLimit', 0.01, 'NumTiles', [8 8]);

        case 'BI-HE'
            threshold = graythresh(img);
            L = img <= threshold * 255;
            H = img > threshold * 255;
            low_eq = histeq(uint8(L .* double(img)));
            high_eq = histeq(uint8(H .* double(img)));
            result = uint8(L) .* low_eq + uint8(H) .* high_eq;

        case 'HE-BW'
            HE_img = histeq(img);
            result = butterworthbpf(double(HE_img), 20, 120, 4);
            result = uint8(mat2gray(result) * 255);

        case 'AHE-BW'
            AHE_img = adapthisteq(img);
            result = butterworthbpf(double(AHE_img), 20, 120, 4);
            result = uint8(mat2gray(result) * 255);

        case 'BI-HE-BW'
            threshold = graythresh(img);
            L = img <= threshold * 255;
            H = img > threshold * 255;
            low_eq = histeq(uint8(L .* double(img)));
            high_eq = histeq(uint8(H .* double(img)));
            BIHE_img = uint8(L) .* low_eq + uint8(H) .* high_eq;
            result = butterworthbpf(double(BIHE_img), 20, 120, 4);
            result = uint8(mat2gray(result) * 255);

        case 'CLAHE-BW'
            CLAHE_img = adapthisteq(img, 'ClipLimit', 0.01, 'NumTiles', [8 8]);
            result = butterworthbpf(double(CLAHE_img), 20, 120, 4);
            result = uint8(mat2gray(result) * 255);

        otherwise
            disp('⚠️ طريقة غير معروفة.');
            return;
    end

    imshow(original_img, 'Parent', ax1);
    imshow(result, 'Parent', ax2);

    output_folder = fullfile('Enhanced_Results', method);
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
    [~, name, ~] = fileparts(filename);
    imwrite(result, fullfile(output_folder, [name, '_' method '.png']));

    fprintf('✅ تم حفظ الصورة في: %s\n', fullfile(output_folder, [name, '_' method '.png']));
end
