# Define two arrays
array1 = [1, 2, 3, 4, 5]
array2 = [6, 7, 8, 9, 10]

# Chec the same length
if len(array1) == len(array2):
    # Use list comprehension to add corresponding elements
    result = [array1[i] + array2[i] for i in range(len(array1))]
else:
    print("Arrays have different lengths.")

# Print the result
print(result)
