class LineCleaner
	def clear_lines(field, field_width, field_height)
		lines_cleared = 0

		0.upto(field_height) do |i|
			if field.select {|c| c[1] == i}.length == field_width then
				field.reject! {|c| c[1] == i }
				lines_cleared += 1
			end
		end

		push_lines_down field, field_height
	
		lines_cleared
	end

	def push_lines_down(field, field_height)
		lines_pushed = 0

		(field_height - 1).downto(0) do |i|
			if field.select {|c| c[1] == i}.length == 0 then
				lines_pushed += 1 if field.any? {|f| f[1] < i }

				field.each do |f|
					f[1] += 1 if f[1] < i
				end
			end
		end

		push_lines_down(field, field_height) if lines_pushed.nonzero?
	end
end
