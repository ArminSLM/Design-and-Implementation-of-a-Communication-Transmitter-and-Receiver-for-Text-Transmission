% Run the main function
lamp=lzw_main();

function lamp=lzw_main()
    % Encode the text file using LZW
    encoded_data = lzw_encoder();

    % Decode the encoded data
    decoded_text = lzw_decoder(encoded_data);

    % Display the decoded text
    disp('Decoded Text:');
    disp(decoded_text);

    % Example of how to use the data in Simulink
    T = 1e-3;
    t1 = 0:length(encoded_data)-1;
    t = t1 * T;
    u = reshape(encoded_data, length(encoded_data), 1);
    lamp.time = t;
    lamp.signals.values = u;
    lamp.signals.dimensions = 1;
end

function encoded_data = lzw_encoder()
    % Prompt the user to select a text file
    [file, path] = uigetfile('*.txt', 'Select a text file');
    if isequal(file, 0)
        disp('User selected Cancel');
        encoded_data = [];
        return;
    else
        filename = fullfile(path, file);
        disp(['User selected ', filename]);
    end

    % Read the content of the file
    fileID = fopen(filename, 'r');
    text = fread(fileID, '*char')';
    fclose(fileID);

    % Encode the text using LZW
    encoded_data = lzw_encode(text);

    % Save the encoded data to a new file
    [file, path] = uiputfile('*.mat', 'Save encoded data as');
    if isequal(file, 0)
        disp('User selected Cancel');
        return;
    else
        save(fullfile(path, file), 'encoded_data');
        disp(['Encoded data saved to ', fullfile(path, file)]);
    end
end

function encoded = lzw_encode(input)
    % Initialize the dictionary with single characters
    dict = containers.Map;
    for i = 0:255
        dict(char(i)) = i;
    end

    % Variables
    current_string = '';
    next_code = 256;
    encoded = [];

    % LZW Encoding
    for i = 1:length(input)
        current_char = input(i);
        new_string = [current_string current_char];
        
        if isKey(dict, new_string)
            current_string = new_string;
        else
            encoded(end+1) = dict(current_string); %#ok<AGROW>
            if next_code <= 2^16 - 1 % Dictionary limit (16 bits)
                dict(new_string) = next_code;
                next_code = next_code + 1;
            end
            current_string = current_char;
        end
    end

    % Add the last code
    if ~isempty(current_string)
        encoded(end+1) = dict(current_string); %#ok<AGROW>
    end
end

function decoded_text = lzw_decoder(encoded_data)
    % Initialize the dictionary with single characters
    dict = containers.Map(num2cell(0:255), arrayfun(@char, 0:255, 'UniformOutput', false));

    % Variables
    current_code = encoded_data(1);
    encoded_data = encoded_data(2:end);
    current_string = dict(current_code);
    decoded_text = current_string;
    next_code = 256;

    % LZW Decoding
    for i = 1:length(encoded_data)
        current_code = encoded_data(i);
        
        if isKey(dict, current_code)
            entry = dict(current_code);
        elseif current_code == next_code
            entry = [current_string current_string(1)];
        else
            error('Decoding error: Invalid code encountered.');
        end
        
        decoded_text = [decoded_text entry]; %#ok<AGROW>
        
        % Add new entry to the dictionary
        if next_code <= 2^16 - 1 % Dictionary limit (16 bits)
            dict(next_code) = [current_string entry(1)];
            next_code = next_code + 1;
        end
        
        current_string = entry;
    end
end


