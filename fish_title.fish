function fish_title
	if test $status != 0;
		set face '|>_<|'
	else 
		set face '|^_^|'
	end

	echo $_  #pid
	echo " "$face
end

