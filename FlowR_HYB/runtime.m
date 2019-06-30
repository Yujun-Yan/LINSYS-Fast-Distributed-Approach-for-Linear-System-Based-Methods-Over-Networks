clear;
%runtime version
file='../data/google.txt';    %graph file: nodeA nodeB weight
p_file='../data/partition_list_google.txt'; %partition ouput from Louvain
D=load(file);
partition_list=load(p_file);
A=spconvert(D);
partition_list=partition_list(2:end,2);
n=max(size(A));%number of nodes
A(n,n)=0;
nparts=max(partition_list);
d=1;  %1: directed graph; 0: undirected
c=0.85;
tic
[E_extra,L_inv_cut,U_inv_cut,L_inv_com,U_inv_com,T1,H3,total_nodes,total_in,total_boundary,total_no_dup_b,total_no_dup] =Preprocess_overlap (partition_list,nparts,n,A,d,c);
time = toc;
disp('preprocessing time');
fprintf('%f\n', time);
n_q =1000;
query_nodes = randi(n, n_q, 1);
disp('query time');
x=cell(n_q,1);
tic
for q=1:n_q
    x{q}=query_overlap(E_extra,L_inv_cut,U_inv_cut,L_inv_com,U_inv_com,T1,H3,total_nodes,total_in,total_boundary,total_no_dup_b,total_no_dup,query_nodes(q),n,c);
end
time = toc;
fprintf('%f\n', time/n_q);
exit;
