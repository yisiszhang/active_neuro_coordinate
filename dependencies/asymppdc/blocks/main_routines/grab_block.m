function y=grab_block(Matrix,Block_index_I,Block_index_J,Block_set)
%
% input: 
%        Matrix - square nxn matrix whose block are to be extracted
%                        (can be generalised)
%        Block_index_I
%        Block_index_J
%        Block_set  - Matrix containg indices for each blocks 
%                     rows - number the blocks (=<n)
%                     columns - number provide the indices per block
%                               (=n - filled with zeros above the number of valid indices)
% output: y - matrix with the grabed components
%
index_x=max_index(Block_set(Block_index_I,:));
index_y=max_index(Block_set(Block_index_J,:));
y=Matrix(index_x,index_y);

function y=max_index(v)
y=find(v==0);
y=v(1:y(1)-1);



