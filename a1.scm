;ID:20193803
;Name: Luk Wing San (Winson Luk)
;Comp4221, Assignment 1

;(Credits)Part 1 is done with reference on http://stackoverflow.com/questions/23635911/permutation-in-scheme-using-recursion 
;------------------------------------------------------------------------------------------------------------
;Part 2
;------------------------------------------------------------------------------------------------------------
;defined graph g
(define g
  '((a . ((b . 5) (c . 8) (d . 3)))
   (b . ((a . 4) (c . 7)))
   (c . ((a . 2) (b . 6) (c . 2) (d . 9)))
   (d . ((b . 1) (c . 4)))))


;the function find-value below is to extract the value from key-value pairs with the key
;key is the namenode to be searched
;key-value pairs is a list of key-value pairs that will be searched, eg b.5 in the namenode of a
;returns the value of the required key-value pair if found or '() if not found
(define (find-value key-value-pairs key) (
	if (null? key-value-pairs)
		'()
		(if (eq? key (car(car key-value-pairs))) 
			(cdr(car key-value-pairs))
			(find-value (cdr key-value-pairs) key))
))
	
;the function edge-weight below is to return the weight between the namenode and the destination-nodename  
;source is the namenode, while destination is the destination-namenode, in which it should be associated with the given source, otherwise #f will be given
;returns #f if no node or no edge linked between source and destination. Otherwise, return edge weight between destination and source node.
(define (edge-weight graph source destination) (
	let ((node (find-value graph source))) (
		if (null? node) 
			#f
			(let ((edge (find-value node destination))) (
				if(null? edge)
					#f
					edge
			))
	)
))

;the path's length, which means the weight associated with each destination namenode and the source, is sum up accumulatively by the function below. If the path doesn't exist, #f will be returned.
(define (accumulate-path-length graph nodes curr sum) (
	if(null? nodes)
		sum
		(let ((segment-length (edge-weight graph curr (car nodes)))) (
			if(not segment-length)
				#f
				(accumulate-path-length graph (cdr nodes) (car nodes) (+ sum segment-length))
		))
))

;the function below returns the total path-length. If it is null, #f will be returned. If it is a single node which is not a path, #f will also be returned
(define (path-length graph nodes) (
	 	if (null? nodes)
			 #f
			(if (null? (cdr nodes)) 
				#f
				(accumulate-path-length graph (cdr nodes) (car nodes) 0))
))




;the function below is the distance function, which allows input to be in the form of graph 'a 'b 'c, a variation of path-length function for convenience, returning total path-length
;args-list is here to form a list to hold all the input parameters after the graph. The number of input parameters is scalable. 
(define(distance graph . args-list)(
	if(null? args-list)
		#f
		(if (null? (cdr args-list))
                     #f
		     (accumulate-path-length graph (cdr args-list) (car args-list) 0)
)))
;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Part1
;--------------------------------------------------------------------------------------------------------------------------------------------------------------
;permutations without duplicates are given out
;remove x from the list lst by recursion
(define (remove x lst)
  (cond
    ((null? lst)'())
    ((eq? x (car lst))(remove x (cdr lst)))
    (else (cons (car lst) (remove x (cdr lst))))))


;permute-helper returns the permutation of the list lst without #f
;lst is the list to be permutated
;if there is just one element inside the list lst, directly return it. Otherwise,use '(map (lambda (j)(cons i j))(permute-helper (remove i lst)))' as inside map to give out all permutations of lst that begins with i.Put 'map(lambda (i)'right to the inside map as outside map so that under all different beginnings different permutations can be given. Finally use apply append outside to eliminate allthe nestings.    
(define (permute-helper lst)

 (cond

    ((eq? (length lst) 1)(list lst))
    (else (apply append(map(lambda (i) (map (lambda (j)(cons i j))

                                            (permute-helper (remove i lst))))lst)))))

;print each of the permutation of the list vertically. If the list is null, return #f. Use #f as the base case, which means #f will be printed out whatever the list is  
;lst is the list to do the permutations 
(define (print-permutations lst) (
                if (null? lst) 
                        #f
                        (let((curr (write (car lst))) (new-line (display "\n"))) (print-permutations (cdr lst))) ;use let to run both write and display, where write prints out the first permutation and display make the next permutation printed out to be on the next line. curr and new-line are both dummy variables only.
))

;lst is the list to do the permutations
;print all items
(define (permute lst) (
        print-permutations (permute-helper lst) 
))
