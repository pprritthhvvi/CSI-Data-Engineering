print("first day of my internship at Celebal Technologies as Data Engineer")

name = "Prithvi sahu"
age = 21
price = 25.99
print("my name is : ", name)
print("my age is : ", age)
print(type(name))
print(type(age))
print(type(price))

# arithmetic operators
a = 5
b = 2
print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a % b) # remainder
print(a ** b) # a^b

# relational operators
a = 50
b = 20
print(a == b) # False
print(a != b) # True
print(a >= b) # True
print(a > b) # True
print(a <= b) # False
print(a < b) # False

# assignment operators
num = 10
num = num + 10 # 10+10 => 20
num += 10
num -= 10
num *= 10
num /= 5
num %= 5
num **= 5
print("num :", num)
print("num : ", num)

# logical operators
a = 50
b = 30
print(not False)
print(not True)
print(not (a >b))

val1 = True
val2 = True
print("ans operator:", val1 and val2)
print("or operator:", val1 or val2)
print("OR operator:", (a == b) or (a > b))

# Type conversion
a = 3.14
a = str(a)
print(type(a))

name = input("enter your name: ")
print("Welcome ", name)

int("5")
val = int(input("enter some value: "))
print(type(val), val)

# Questions

# 1
first = int(input("enter first : "))
second = int(input("enter second : "))
print("sum =", first + second)

# 2
side = float(input("enter square side : "))
print("area =", side * side)

# 3
a = float(input("enter first : "))
b = float(input("enter second: "))
print("area=", side ** 2)
print("avg =", (a+b)/2)
print(a >= b)