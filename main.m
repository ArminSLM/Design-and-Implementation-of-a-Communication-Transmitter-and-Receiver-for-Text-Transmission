
% Step 0: Prompt the user to select a file
[file, path] = uigetfile('*.txt', 'Select a text file');
if isequal(file, 0)
    disp('User selected Cancel');
    return;
else
    filename = fullfile(path, file);
    disp(['User selected ', filename]);
end

% Step 1: Read the content of the file
fileID = fopen(filename, 'r');
text = fread(fileID, '*char')';
fclose(fileID);

% Step 2: Count the frequency of each character
unique_chars = unique(text);
freq = histc(text, unique_chars);

% Step 3: Calculate probabilities
probabilities = freq / sum(freq);

% Step 4: Calculate entropy
entropy = -sum(probabilities .* log2(probabilities));

% Display entropy
fprintf('Entropy of the text: %.4f bits\n', entropy);

% Step 5: Build the Huffman tree
symbols = num2cell(unique_chars); % Convert to cell array of characters
dict = huffmandict(symbols, probabilities);

% Step 6: Encode the text
text_cell = num2cell(text); % Convert text to cell array of characters
encoded_binary = huffmanenco(text_cell, dict);

% Convert encoded binary sequence to a string of '0's and '1's
encoded_text = sprintf('%d', encoded_binary);

% Step 7: Calculate the average length of Huffman encoded symbols
avg_length = 0;
for i = 1:length(dict)
    symbol_length = length(dict{i, 2});
    avg_length = avg_length + probabilities(i) * symbol_length;
end

% Step 8: Calculate efficiency
efficiency = entropy / avg_length;


%rec=out.varo;
%rec1=reshape(rec,1,[]);
%huffman_decoder(rec1);

% Step 9: Decode the text (optional)
%decoded_cell = huffmandeco(rec, dict);
%decoded_text = cell2mat(decoded_cell); % Convert back to character array

% Display results
fprintf('Original Text: %s\n', text);
fprintf('Encoded Text: %s\n', encoded_text);
%fprintf('Decoded Text: %s\n', decoded_text);
fprintf('Average Length of Huffman Encoded Symbols: %.4f bits\n', avg_length);
fprintf('Efficiency of Huffman Coding: %.4f\n', efficiency);

T=1e-3;
t1=0:14274;
t=t1*T;
u=reshape(encoded_binary,14275,1);
yes.time=t;
 yes.signals.values=u;
 yes.signals.dimensions=1;
