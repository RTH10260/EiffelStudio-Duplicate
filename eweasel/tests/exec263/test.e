class 
	  TEST[G]

create
	make

feature -- Initialization

	make is
			-- A creation procedure
		do
			io.put_string (generating_type.name_32.to_string_8)
			io.put_new_line

		--	create i.make
		--	create s.make
		--	create sl.make

      end

	i: TEST [INTEGER]
	s: TEST [STRING] 
	sl: TEST [LIST [STRING]]

end -- class TEST
