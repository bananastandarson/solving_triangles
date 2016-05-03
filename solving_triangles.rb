# encoding: UTF-8

# coding: UTF-8

# -*- coding: UTF-8 -*-


class SolvingTriangles

	def initialize(given,given_array,givens_hash)
		@given = given
		@given_array = given_array
		@givens_hash = givens_hash
		
		givens

	end
		
	def given_error
		puts "You have indicated an angle or a side twice. Please check your givens."	
		@given_array = []
		
		puts "What sides and angles are you given? Do not provide values yet. (e.g. A C a)"
		given = gets.chomp
		@given_array = given.split(" ")
			
	if @given_array.length != 3
		puts "Please make sure to provide all three given conditions. (e.g. A C a)"
		given = gets.chomp
		@given_array = given.split(" ")
		
	else
	end
		
		
	 
	end
	
	def givens
		# determine scenario based on givens
		given_dncase = @given.downcase.split(" ")
		
		sides_a = 0
		sides_b = 0
		sides_c = 0
		sides = 0

		angles_a = 0
		angles_b = 0
		angles_c = 0
		angles = 0

		@given_array.each {|x|
			case x
				when "a"
					sides_a += 1
					sides += 1
				when "b"
					sides_b += 1
					sides += 1
				when "c"
					sides_c += 1
					sides += 1
				when "A"
					angles_a += 1
					angles += 1
				when "B"
					angles_b += 1
					angles += 1
				when "C"
					angles_c += 1
					angles += 1
				else
			end
				
			}
			
		# puts "#{sides} sides"
		# puts "#{angles} angles" 
		
		if sides_a == 2 || sides_b == 2 || sides_c == 2 || angles_a == 2 || angles_b == 2 || angles_c == 2
			given_error
			else
			end
			
		# Get values for conditions
		puts "Please indicate the values for your givens. Angles must be in degrees."
		print "#{@given_array[0]} = "
		first_value = gets.chomp
		print "#{@given_array[1]} = "
		second_value = gets.chomp
		print "#{@given_array[2]} = "
		third_value = gets.chomp
			
		@givens_hash[@given_array[0]] = first_value.to_f
		@givens_hash[@given_array[1]] = second_value.to_f
		@givens_hash[@given_array[2]] = third_value.to_f
		
		
		if @givens_hash[@given_array[0]] == 0 || @givens_hash[@given_array[1]] == 0 || @givens_hash[@given_array[2]] == 0
			puts "You have indicated that one of the given conditions has a measure of zero. If this is incorrect, please indicate correct value."
			print "#{@given_array[0]} = "
			first_value = gets.chomp
			print "#{@given_array[1]} = "
			second_value = gets.chomp
			print "#{@given_array[2]} = "
			third_value = gets.chomp
			@givens_hash[@given_array[0]] = first_value.to_f
			@givens_hash[@given_array[1]] = second_value.to_f
			@givens_hash[@given_array[2]] = third_value.to_f
		else
		end
		
					
		# convert given angles, if any, from degrees to radians
		if @givens_hash.has_key?("A")
			@givens_hash["A"] = @givens_hash["A"]*Math::PI/180
		end
		if @givens_hash.has_key?("B")
			@givens_hash["B"] = @givens_hash["B"]*Math::PI/180
		end 
		if @givens_hash.has_key?("C")
			@givens_hash["C"] = @givens_hash["C"]*Math::PI/180
		end
		
		@givens_hash = Hash[@givens_hash.sort]
		# puts "#{@givens_hash}"
		a = @givens_hash.values[0]
		b = @givens_hash.values[1]
		c = @givens_hash.values[2]
		
		#refactor here...indicate array of just the keys
		d = @givens_hash.keys[0]
		e = @givens_hash.keys[1]
		f = @givens_hash.keys[2]
				
		# this is to determine the third letter
		third_something = [d,e,f]
		third_something = third_something.map {|x| x.downcase} 
		# print third_something
		
		if third_something.include?("a") && third_something.include?("c") 
			third_letter = "b"
		elsif third_something.include?("a") && third_something.include?("b") 
			third_letter = "c"
		elsif third_something.include?("b") && third_something.include?("c")  
			third_letter = "a"
		end
		
		# puts "Third letter is #{third_letter}" 
		
		opposite_pairs_a = 0
		opposite_pairs_b = 0
		opposite_pairs_c = 0
		opposite_pairs = 0

		given_dncase.each {|x|
			case x
			when "a"
			opposite_pairs_a += 1
			when "b"
			opposite_pairs_b += 1
			when "c"
			opposite_pairs_c += 1
			else
			end
			}

		opposite_pairs = 1 if opposite_pairs_a == 2 || opposite_pairs_b == 2 || opposite_pairs_c == 2

		# puts "#{opposite_pairs} opposite_pairs"

		# sss: 0 opp 3 sides
		# sas: 0 opp 2 sides 1 ang
		# ssa: 1 opp 2 sides 1 ang
		# asa: 0 opp 1 side 2 ang
		# aas: 1 opp 1 side 2 ang

		# based on givens send to appropriate solving method
		if sides == 3
				sss(a,b,c,d,e,f)
			elsif sides == 2 && opposite_pairs == 0
				sas(a,b,c,d,e,f)
			elsif sides == 2 && opposite_pairs == 1
				ssa(a,b,c,d,e,f,third_letter)
			elsif sides == 1 && opposite_pairs == 0
				asa(a,b,c,d,e,f)
			elsif sides == 1 && opposite_pairs == 1
				aas(a,b,c,d,e,f,third_letter)
				
			else puts "something wrong yo."
		end

	end

	# def los_side(A,B,c)
		# # finds the side opposite of side 'a', assuming side 'b' and angle 'C' are an opposite pair
		# side = C*Math.sin(A)/Math.sin(B)
		
	# end
	
	# def los_angle(A,b,c)
		# # finds the angle opposite of side 'b', assuming angle 'A' and side 'c' are an opposite pair
		# angle = Math.asin(b*(Math.sin(A)/c))*180/Math::PI	
		
	# end
	
	# def loc_side(A,b,c)
		# # finds the side opposite of angle 'b'
		# side = (b**2 + c**2 - 2*b*c*(Math.cos(A)))**(0.5)
	# end
	
	# def loc_angle(a,b,c)
	# # finds the angle opposite of angle 'c'
	# angle = Math.acos((a**2 + b**2 - c**2) / (2*a*b))
	# end
	
	def ssa(a,s1,s2,d,e,f,third_letter)
		puts "Your givens indicate you have a SSA scenario."
		
		if d.downcase == e
		# a is opposite of s1
		x = s2*(Math.sin(a)/s1)
			puts "The ratio of #{d.downcase}/#{e} = #{x}"
			if x < -1 || x > 1 
				puts "There is no triangle that can satisfy the given conditions."
				
				# restart method ?
				
				elsif 
				# there are possibly 1 or 2 solutions
				a2 = Math.asin(x)	
					puts "#{f.upcase} = #{a2}"				
				a3 = Math::PI - (a + a2)
					puts "#{third_letter.upcase} = #{a3}"
				s3 = s1*Math.sin(a3)/Math.sin(a)
					puts "#{third_letter} = #{s3}"
				a2i = Math::PI - a2
					puts "#{f.upcase}2 = #{a2i}"		
					if a2i + a > Math::PI
						#there is only one solutions
						puts "The only solution set is: \n 
						#{f.upcase} = #{(a2*180/Math::PI).round(2)}\n
						#{third_letter.downcase} = #{s3.round(2)}\n
						#{third_letter.upcase} = #{(a3*180/Math::PI).round(2)}"
						
					elsif a2i + a < Math::PI
						# there are two 2 solutions
						puts "There are two triangles that satisfy the given conditions."
						# first solution using original givens
						puts "The first solution set is: \n 
						#{f.upcase}1 = #{(a2*180/Math::PI).round(2)}\n
						#{third_letter.downcase}1 = #{s3.round(2)}\n
						#{third_letter.upcase}1 = #{(a3*180/Math::PI).round(2)}"
						
						# second solution
						a3i = Math::PI - (a + a2i)
						s3i = s1*Math.sin(a3i)/Math.sin(a)
						
						puts "The second solution set is: \n
						#{f.upcase}2 = #{(a2i*180/Math::PI).round(2)}\n
						#{third_letter.downcase}2 = #{s3i.round(2)}\n
						#{third_letter.upcase}2 = #{(a3i*180/Math::PI).round(2)}"
						
					end
				
			end

		
		elsif d.downcase == f
		# a is opposite of s2
		x = s1*(Math.sin(a)/s2)
		puts "The ratio is #{x}"
			if x < -1 || x > 1 
				puts "There is no triangle that can satisfy the given conditions."
				
				# restart method 
				
				elsif 
				# there are possibly 1 or 2 solutions
				a1 = Math.asin(x)	
					puts "#{e.upcase} = #{a1}"
				a3 = Math::PI - (a + a1)
				s3 = s2*Math.sin(a3)/Math.sin(a)
				a1i = Math::PI - a1.to_f
				a1i = a1i.to_f
					if a1i + a > Math::PI
						#there is only one solutions
						puts "The only solution set is: \n 
						#{e.upcase} = #{(a1*180/Math::PI).round(2)}\n
						#{third_letter.downcase} = #{s3.round(2)}\n
						#{third_letter.upcase} = #{(a3*180/Math::PI).round(2)}"
						
					elsif a1i + a < Math::PI
						# there are two 2 solutions
						puts "There are two triangles that satisfy the given conditions."
						# first solution using original givens
						puts "The first solution set is: \n 
						#{e.upcase}1 = #{(a1*180/Math::PI).round(2)}\n
						#{third_letter.downcase}1 = #{s3.round(2)}\n
						#{third_letter.upcase}1 = #{(a3*180/Math::PI).round(2)}"
						
						# second solution
						a3i = Math::PI - (a + a1i)
						s3i = s2*Math.sin(a3i)/Math.sin(a)
						
						puts "The second solution set is: \n 
						#{e.upcase}2 = #{(a1i*180/Math::PI).round(2)}\n
						#{third_letter.downcase}2 = #{s3i.round(2)}\n
						#{third_letter.upcase}2 = #{(a3i*180/Math::PI).round(2)}"
						
					end
				
			end
		end
		
		
		

	end

	def asa(a1,a2,s3,d,e,f)
		puts "Your givens indicate you have a ASA scenario."
		a3 = Math::PI - (a1 + a2)
		puts "#{f.upcase} = #{(a3*180/Math::PI).round(2)}"
		
		s1 = s3*Math.sin(a1)/Math.sin(a3)
		s2 = s3*Math.sin(a2)/Math.sin(a3)
		puts "#{d.downcase} = #{s1.round(2)}"
		puts "#{e.downcase} = #{s2.round(2)}"

	end

	def aas(a1,a2,s,d,e,f,third_letter)
		puts "Your givens indicate you have a AAS scenario." 
		a3 = Math::PI - (a1 + a2)
			
		#puts "Third letter is #{third_letter}" 	
		puts "#{third_letter.upcase} = #{(a3*180/Math::PI).round(2)}"		
				
		if e.downcase == f
			# this means the given side is opposite of a2
			s1 = s*Math.sin(a1)/Math.sin(a2)
			s3 = s*Math.sin(a3)/Math.sin(a2)
			puts "#{d.downcase} = #{s1.round(2)}"	
			puts "#{third_letter} = #{s3.round(2)}"	
				
		elsif d.downcase == f
			# this means the given side is opposite of a1
			s2 = s*Math.sin(a2)/Math.sin(a1)
			s3 = s*Math.sin(a3)/Math.sin(a1)
			puts "#{e.downcase} = #{s2.round(2)}"	
			puts "#{third_letter} = #{s3.round(2)}"	
		else 
		
		end
		
	
	end

	def sss(x,y,z,d,e,f)

		puts "\n Your givens indicate you have a SSS scenario."
				
		ang1 = Math.acos((y**2 + z**2 - x**2) / (2*y*z))
		ang1 = ang1*180/Math::PI
				
		ang2 = Math.acos((x**2 + z**2 - y**2) / (2*x*z))
		ang2 = ang2*180/Math::PI
		
		ang3 = 180 - (ang1 + ang2)
		
		if ang1 == 0 || ang2 == 0 || ang3 == 0
			puts "There is no possible triangle that fit these conditions because the Triangle Inequality Theorem states that the sum of the lengths of any two sides of a triangle is greater than the length of the third side. Duh."
		else
			puts "#{d.upcase} = #{ang1.round(2)}"
			puts "#{e.upcase} = #{ang2.round(2)}"
			puts "#{f.upcase} = #{ang3.round(2)}"
		end
	end

	def sas(a3,s1,s2,d,e,f)
		squared = "\u00B2"
		sqrt = "\u221A"
		dot = "\u00B7"
		invrs = "\u207B" + "\u00B9"
		deg = "\u00B0"
		s3 = (s1**2 + s2**2 - 2*s1*s2*(Math.cos(a3)))**(0.5)
		a1 = Math.asin(s1*(Math.sin(a3)/s3))*180/Math::PI			
		a2 = 180 - (a1 + a3*180/Math::PI)
		puts "\n 
		Your givens indicate you have a SAS scenario \n
		because you have two sides and an angle that is touching both of those sides. \n
		This allows you to use the \n
		Law of Cosine Formula \n
		c#{squared} = a#{squared} + b#{squared} - 2ab#{dot}cosC \n
		to find the length of the side opposite of the given angle. \n
		#{d.downcase}#{squared} = #{e}#{squared} + #{f}#{squared} - 2#{e}#{f}#{dot}cos#{d.upcase}\n
		#{d.downcase}#{squared} = #{s1}#{squared} + #{s2}#{squared} - 2(#{s1})(#{s2})#{dot}cos(#{(a3*180/Math::PI).round(3)}) \n
		#{d.downcase}#{squared} = #{(s3**2).round(3)} \n
		#{d.downcase} = #{sqrt}(#{(s3**2).round(3)}) \n
		#{d.downcase} = #{s3.round(2)}"
		
		puts "\n 
		Now that you have an angle and a side opposite of that angle, \n
		you can now use the Law of Sines to find either of the remaining two unknown angles. \n
		Here, we'll first find the angle opposite of '#{e.downcase}'. \n
		The Law of Sines Formula is \n
		(sinA)/a = (sinB)/b = (sinC)/c. \n
		Using side '#{d.downcase}', which you just found, we have: \n
		(sin#{e.upcase})/#{e.downcase} = (sin#{d.upcase})/#{d.downcase} \n
		To make our lives easier, let's first isolate for the angle '#{e.upcase}' we are solving for \n
		by multiplying both sides of the equation by #{e.downcase}. \n
		(sin#{e.upcase}) = #{e.downcase}#{dot}(sin#{d.upcase})/#{d.downcase} \n
		Then take the sine inverse (or arcsine) of both sides of the equation. \n
		#{e.upcase} = sin#{invrs}[#{e.downcase}#{dot}(sin#{d.upcase})/#{d.downcase}] \n
		#{e.upcase} = sin#{invrs}[#{s1}#{dot}(sin#{(a3*180/Math::PI).round(2)})/#{s3.round(2)}] \n
		As you're inputting this into your calculator, \n
		be sure to check that you're in DEGREE MODE! \n
		#{e.upcase} = #{a1.round(2)}#{deg} \n
		Lastly, now that you have two angles of your triangle, \n
		you can easily find the last angle measure '#{f.upcase}' by using the Triangle Angle Sum Theorem \n
		which states that the sum of all angles of a triangle must be 180#{deg}. \n
		#{d.upcase} + #{e.upcase} + #{f.upcase} = 180#{deg} \n
		#{f.upcase} = 180 - (#{d.upcase} + #{e.upcase}) \n
		#{f.upcase} = 180 - (#{a1.round(2)} + #{(a3*180/Math::PI).round(2)}) \n
		#{f.upcase} = #{a2.round(2)}#{deg}"
		
		puts "\n
		Bah-dah-BING! \n
		#{d.downcase} = #{s3.round(2)} \n
		#{e.upcase} = #{a1.round(2)}#{deg} \n
		#{f.upcase} = #{a2.round(2)}#{deg}"
	
	end

end


	puts "What sides and angles are you given? Do not provide values yet. (e.g. A C a)"
	given = gets.chomp
	given_array = given.split(" ")
	
	if given_array.length != 3
		puts "Please make sure to provide all three given conditions. (e.g. A C a)"
		given = gets.chomp
		given_array = given.split(" ")
		
	else
	end
	
	
		
	givens_hash = Hash.new(0)
	SolvingTriangles.new(given,given_array,givens_hash)

