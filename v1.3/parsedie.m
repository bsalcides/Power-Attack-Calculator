function par = parsedie(str)

str = strcat(strcat('?', lower(str)), '?');
ind = strfind(str, 'd');

for i=1:length(ind)
    j=1;
    while ~isnan(str2double(str(ind(i)+j)))
        j = j+1;
    end
    if isnan(str2double(str(ind(i)-1)))
        aff = str(1:ind(i)+j-1);
        suf = str(ind(i)+j:end);
        aff = replace(aff,'d', 'f(');
        str = strcat(strcat(aff, ')'), suf);
        ind = ind + 2;
    else
        aff = str(1:ind(i)+j-1);
        suf = str(ind(i)+j:end);
        aff = replace(aff,'d', '*f(');
        str = strcat(strcat(aff, ')'), suf);
        ind = ind + 3;
    end
end

str = replace(str,'f','d');
par = replace(str,'?', '');
par = string(par);

end

