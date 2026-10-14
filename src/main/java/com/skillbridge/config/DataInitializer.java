package com.skillbridge.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.skillbridge.entity.Category;
import com.skillbridge.repository.CategoryRepository;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public void run(String... args) throws Exception {
        // Sirf tab insert karo jab categories khaali ho
        if (categoryRepository.count() == 0) {

            categoryRepository.save(new Category("Web Development",
                "Websites, web apps, and online platforms", "💻"));

            categoryRepository.save(new Category("Mobile Development",
                "iOS and Android mobile applications", "📱"));

            categoryRepository.save(new Category("Graphic Design",
                "Logos, branding, posters, and illustrations", "🎨"));

            categoryRepository.save(new Category("UI/UX Design",
                "User interface and user experience design", "✨"));

            categoryRepository.save(new Category("Digital Marketing",
                "SEO, social media, and online campaigns", "📊"));

            categoryRepository.save(new Category("Content Writing",
                "Blog posts, articles, and copywriting", "✍️"));

            categoryRepository.save(new Category("Video Editing",
                "Video production, editing, and animation", "🎬"));

            categoryRepository.save(new Category("Data Science",
                "Data analysis, machine learning, and AI", "🧠"));

            System.out.println("✅ Default categories inserted successfully!");
        }
    }
}