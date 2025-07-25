// QuickCash Auto Git Helper
// This will help with automatic GitHub uploads

const { exec } = require('child_process');
const fs = require('fs');

class GitAutoUploader {
    constructor() {
        this.isUploading = false;
        this.uploadQueue = [];
    }

    // Auto upload function
    async autoUpload(message = 'Auto upload changes') {
        if (this.isUploading) {
            console.log('⏳ Upload already in progress...');
            return;
        }

        this.isUploading = true;
        console.log('🚀 Starting auto upload to GitHub...');

        try {
            // Run the auto upload script
            await this.runCommand('./auto-git-upload.sh');
            console.log('✅ Successfully uploaded to GitHub!');
        } catch (error) {
            console.error('❌ Error uploading to GitHub:', error);
        } finally {
            this.isUploading = false;
        }
    }

    // Run shell command
    runCommand(command) {
        return new Promise((resolve, reject) => {
            exec(command, (error, stdout, stderr) => {
                if (error) {
                    reject(error);
                    return;
                }
                console.log(stdout);
                if (stderr) console.error(stderr);
                resolve(stdout);
            });
        });
    }

    // Watch for file changes and auto upload
    watchAndUpload(filePath = './quickcash-complete-app.html') {
        if (!fs.existsSync(filePath)) {
            console.log('❌ File not found:', filePath);
            return;
        }

        fs.watchFile(filePath, (curr, prev) => {
            console.log('📝 File changed, auto uploading...');
            setTimeout(() => {
                this.autoUpload('File change detected - auto upload');
            }, 2000); // Wait 2 seconds before upload
        });

        console.log('👁️ Watching file for changes:', filePath);
    }
}

// Export for use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = GitAutoUploader;
}

// Browser usage
if (typeof window !== 'undefined') {
    window.GitAutoUploader = GitAutoUploader;
}

console.log('🔧 Git Auto Uploader initialized!');