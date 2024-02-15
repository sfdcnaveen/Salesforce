public class Calculator {
    public Integer firstNumber {get; set;}
    public Integer secondNumber {get; set;}
    public Double result {get; set;}
    public Integer Addition(){
        return firstNumber + secondNumber;
    }
    public Integer Subtraction(){
        return firstNumber - secondNumber;
    }
    public Integer Multiplication(){
        return firstNumber * secondNumber;
    }
    public Double Division(){
        return firstNumber / secondNumber;
    }
    
    
}