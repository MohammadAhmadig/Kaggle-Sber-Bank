function n = K_Fold (num, k)
	tmp = floor(num / k);
	n = zeros(tmp, k);
	p = randperm(num);
	
	for i=1:k
		n(:, i) = p( (tmp*(i-1))+1:tmp*i);
	end
end