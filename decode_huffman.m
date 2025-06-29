function huffman_decoder(encoded_binary)
    % Function to decode Huffman encoded data back to text

    % Step 1: Define the Huffman dictionary (replace with your actual Huffman dictionary)
    symbols = {'A', 'B', 'C', 'D'}; % Example symbols
    probabilities = [0.4, 0.3, 0.2, 0.1]; % Example probabilities
    dict = huffmandict(symbols, probabilities); % Example Huffman dictionary

    % Step 2: Decode the Huffman encoded binary sequence
    decoded_cell = huffmandeco(encoded_binary, dict);

    % Step 3: Convert decoded symbols to text
    decoded_text = cell2mat(decoded_cell);

    % Display the decoded text
    disp(['Decoded text: ', decoded_text]);
end

% Example usage:
% Replace 'your_encoded_binary_here' with your actual encoded binary sequence
encoded_binary = [1 0 0 0 1 1 0 1 1 0 0 1 0 1 0]; % Example encoded binary sequence

% Call the decoder function
huffman_decoder(encoded_binary);
