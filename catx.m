function R = catx(dim,A,options)

arguments
    dim (1,1) {mustBeInteger}
end
arguments(Repeating)
    A
end
arguments
    options.PaddingValue = nan
end

sizes = cellfun(@size,A,'UniformOutput',false);
dims = cellfun(@length,sizes,'UniformOutput',false);
maxdim = max([dims{:} dim]);

for iSize = 1:length(sizes)
    sizes{iSize}(end+1:end+maxdim-length(sizes{iSize})) = 1;
end
sizes = cat(1,sizes{:});
maxSize = max(sizes);

resSize = maxSize;
resSize(dim) = sum(sizes(:,dim));

R = repmat(options.PaddingValue,resSize);

beg = 0;
for iA = 1:numel(A)
    ind = false(resSize);
    idx = arrayfun(@(x)1:x,sizes(iA,:),'UniformOutput',false);
    idx{dim} = idx{dim} + beg;
    ind(idx{:})=true;
    R(ind)=A{iA}(:);
    beg = beg + length(idx{dim});
end

end
