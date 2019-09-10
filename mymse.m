function this = mymse(icomp, ibase)
    this = sum((ibase(:) - icomp(:)).^2) / numel(ibase);
end