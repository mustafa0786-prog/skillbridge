package com.skillbridge;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashGenerator {

    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String password = "admin123";
        String hash = encoder.encode(password);

        System.out.println();
        System.out.println("===========================================");
        System.out.println("Password:  " + password);
        System.out.println("Hash:      [" + hash + "]");
        System.out.println("Length:    " + hash.length());
        System.out.println("Starts:    " + hash.substring(0, 7));
        System.out.println("Verify:    " + encoder.matches(password, hash));
        System.out.println("===========================================");
        System.out.println();
        System.out.println("--- Copy this SQL command ---");
        System.out.println("UPDATE users SET password = '" + hash + "' WHERE email = 'admin@skillbridge.com';");
    }
}