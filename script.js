// Mobile Navigation Toggle
const navToggle = document.querySelector('.nav-toggle');
const navMenu = document.querySelector('.nav-menu');

navToggle.addEventListener('click', () => {
    navMenu.classList.toggle('active');
    navToggle.classList.toggle('active');
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-menu a').forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
        navToggle.classList.remove('active');
    });
});

// Navbar scroll effect
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 100) {
        navbar.style.background = 'rgba(255, 255, 255, 0.98)';
        navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.15)';
    } else {
        navbar.style.background = 'rgba(255, 255, 255, 0.95)';
        navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
    }
});

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const offsetTop = target.offsetTop - 80;
            window.scrollTo({
                top: offsetTop,
                behavior: 'smooth'
            });
        }
    });
});

// Hero buttons functionality
document.querySelector('.btn-primary').addEventListener('click', () => {
    document.querySelector('#contact').scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
    });
});

document.querySelector('.btn-secondary').addEventListener('click', () => {
    document.querySelector('#destinations').scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
    });
});

// Search functionality
document.querySelector('.search-btn').addEventListener('click', (e) => {
    e.preventDefault();
    const destination = document.querySelector('.search-field input[placeholder="Where to?"]').value;
    const departure = document.querySelector('.search-field input[type="date"]:first-of-type').value;
    const returnDate = document.querySelector('.search-field input[type="date"]:last-of-type').value;
    const guests = document.querySelector('.search-field select').value;
    
    if (!destination) {
        alert('Please enter a destination');
        return;
    }
    
    // Simulate search functionality
    alert(`Searching for trips to ${destination}\nDeparture: ${departure || 'Not specified'}\nReturn: ${returnDate || 'Not specified'}\nGuests: ${guests}`);
});

// Destination cards interaction
document.querySelectorAll('.btn-outline').forEach(button => {
    button.addEventListener('click', (e) => {
        const card = e.target.closest('.destination-card');
        const destination = card.querySelector('h3').textContent;
        const price = card.querySelector('.destination-price').textContent;
        
        alert(`You're interested in ${destination}!\nPrice: ${price}\n\nThis would normally redirect to a detailed booking page.`);
    });
});

// Contact form handling
document.querySelector('.contact-form').addEventListener('submit', (e) => {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const name = e.target.querySelector('input[placeholder="Your Name"]').value;
    const email = e.target.querySelector('input[placeholder="Your Email"]').value;
    const phone = e.target.querySelector('input[placeholder="Phone Number"]').value;
    const service = e.target.querySelector('select').value;
    const message = e.target.querySelector('textarea').value;
    
    // Basic validation
    if (!name || !email || !message) {
        alert('Please fill in all required fields (Name, Email, and Message)');
        return;
    }
    
    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address');
        return;
    }
    
    // Simulate form submission
    const submitBtn = e.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    
    submitBtn.textContent = 'Sending...';
    submitBtn.disabled = true;
    
    setTimeout(() => {
        alert(`Thank you, ${name}! Your message has been sent successfully.\n\nWe'll get back to you within 24 hours at ${email}.`);
        e.target.reset();
        submitBtn.textContent = originalText;
        submitBtn.disabled = false;
    }, 2000);
});

// Animate elements on scroll
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe service cards, destination cards, and testimonial cards
document.querySelectorAll('.service-card, .destination-card, .testimonial-card').forEach(card => {
    observer.observe(card);
});

// Counter animation for stats
const animateCounters = () => {
    const counters = document.querySelectorAll('.stat h3');
    
    counters.forEach(counter => {
        const target = parseInt(counter.textContent.replace(/[^\d]/g, ''));
        const duration = 2000; // 2 seconds
        const increment = target / (duration / 16); // 60fps
        let current = 0;
        
        const updateCounter = () => {
            current += increment;
            if (current < target) {
                counter.textContent = Math.floor(current).toLocaleString() + (counter.textContent.includes('+') ? '+' : '');
                requestAnimationFrame(updateCounter);
            } else {
                counter.textContent = target.toLocaleString() + (counter.textContent.includes('+') ? '+' : '');
            }
        };
        
        updateCounter();
    });
};

// Trigger counter animation when about section is visible
const aboutSection = document.querySelector('.about');
const aboutObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateCounters();
            aboutObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

if (aboutSection) {
    aboutObserver.observe(aboutSection);
}

// Add loading animation delay for cards
document.addEventListener('DOMContentLoaded', () => {
    // Set initial state for animated elements
    document.querySelectorAll('.service-card, .destination-card, .testimonial-card').forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
    });
});

// Social media links functionality
document.querySelectorAll('.social-links a').forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        const platform = e.target.className.includes('facebook') ? 'Facebook' : 
                         e.target.className.includes('twitter') ? 'Twitter' :
                         e.target.className.includes('instagram') ? 'Instagram' : 'YouTube';
        
        alert(`This would normally open our ${platform} page.\n\nFor demo purposes, we're just showing this message.`);
    });
});

// Add parallax effect to hero section
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const hero = document.querySelector('.hero');
    const rate = scrolled * -0.5;
    
    if (hero) {
        hero.style.transform = `translateY(${rate}px)`;
    }
});

// Add hover effects for service cards
document.querySelectorAll('.service-card').forEach(card => {
    card.addEventListener('mouseenter', () => {
        card.style.transform = 'translateY(-15px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', () => {
        card.style.transform = 'translateY(0) scale(1)';
    });
});

// Add click effects for destination cards
document.querySelectorAll('.destination-card').forEach(card => {
    card.addEventListener('click', () => {
        const destination = card.querySelector('h3').textContent;
        const price = card.querySelector('.destination-price').textContent;
        const rating = card.querySelector('.destination-rating span').textContent;
        
        // Create modal-like effect (simplified)
        const modal = document.createElement('div');
        modal.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            opacity: 0;
            transition: opacity 0.3s ease;
        `;
        
        const modalContent = document.createElement('div');
        modalContent.style.cssText = `
            background: white;
            padding: 2rem;
            border-radius: 15px;
            max-width: 500px;
            text-align: center;
            transform: scale(0.8);
            transition: transform 0.3s ease;
        `;
        
        modalContent.innerHTML = `
            <h2 style="color: #2563eb; margin-bottom: 1rem;">${destination}</h2>
            <p style="margin-bottom: 1rem;">${price}</p>
            <p style="margin-bottom: 2rem; color: #6b7280;">Rating: ${rating}</p>
            <p style="margin-bottom: 2rem; color: #6b7280;">This is a detailed view of the destination. In a real application, this would show more information, images, and booking options.</p>
            <button style="background: #2563eb; color: white; border: none; padding: 12px 30px; border-radius: 25px; cursor: pointer; margin-right: 1rem;">Book Now</button>
            <button style="background: transparent; color: #2563eb; border: 2px solid #2563eb; padding: 10px 28px; border-radius: 25px; cursor: pointer;">Close</button>
        `;
        
        modal.appendChild(modalContent);
        document.body.appendChild(modal);
        
        // Animate in
        setTimeout(() => {
            modal.style.opacity = '1';
            modalContent.style.transform = 'scale(1)';
        }, 10);
        
        // Close functionality
        modalContent.querySelector('button:last-child').addEventListener('click', () => {
            modal.style.opacity = '0';
            modalContent.style.transform = 'scale(0.8)';
            setTimeout(() => {
                document.body.removeChild(modal);
            }, 300);
        });
        
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.opacity = '0';
                modalContent.style.transform = 'scale(0.8)';
                setTimeout(() => {
                    document.body.removeChild(modal);
                }, 300);
            }
        });
    });
});

// Add typing effect to hero title
const heroTitle = document.querySelector('.hero-content h1');
if (heroTitle) {
    const originalText = heroTitle.textContent;
    heroTitle.textContent = '';
    
    let i = 0;
    const typeWriter = () => {
        if (i < originalText.length) {
            heroTitle.textContent += originalText.charAt(i);
            i++;
            setTimeout(typeWriter, 100);
        }
    };
    
    // Start typing effect after a short delay
    setTimeout(typeWriter, 1000);
}

// Add scroll progress indicator
const createScrollIndicator = () => {
    const indicator = document.createElement('div');
    indicator.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 0%;
        height: 3px;
        background: linear-gradient(135deg, #2563eb, #1d4ed8);
        z-index: 10001;
        transition: width 0.1s ease;
    `;
    document.body.appendChild(indicator);
    
    window.addEventListener('scroll', () => {
        const scrollPercent = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;
        indicator.style.width = scrollPercent + '%';
    });
};

// Initialize scroll indicator
createScrollIndicator();

console.log('Wanderlust Travel Agency website loaded successfully! 🌍✈️');