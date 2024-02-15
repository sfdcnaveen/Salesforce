@IsTest
private class MathOperationsTest {
    @IsTest
    static void testAddition() {
        Integer result = MathOperations.add(5, 3);
        System.assertEquals(8, result, 'Addition result is incorrect.');
    }

    @IsTest
    static void testSubtraction() {
        Integer result = MathOperations.subtract(5, 9);
        System.assertEquals(8, result, 'Subtraction result is incorrect.');
    }
    
    @IsTest
    static void testMultiplication() {
        Integer result = MathOperations.multiply(5, 3);
        System.assertEquals(8, result, 'Multiplication result is incorrect.');
    }

    @IsTest
    static void testDivision() {
        Decimal result = MathOperations.divide(15, 3);
        System.assertEquals(5.0, result, 'Division result is incorrect.');
    }

    @IsTest
    static void testDivisionByZero() {
        Decimal result = MathOperations.divide(10, 0);
        System.assertEquals(null, result, 'Division by zero should return null.');
    }
}