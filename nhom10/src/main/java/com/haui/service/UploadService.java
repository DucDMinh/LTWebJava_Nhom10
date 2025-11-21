package com.haui.service;

import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadService {

    @Autowired
    private ServletContext servletContext;

    public String handleSaveUploadFile(String nameFile, MultipartFile file) {
        if (file.isEmpty()) {
            return "";
        }
        String rootPath = this.servletContext.getRealPath("/WEB-INF/resources/admin/images/user");
        String finalName = "";
        try {
            byte[] bytes = file.getBytes();

            File dir = new File(rootPath + File.separator + nameFile);
            if (!dir.exists())
                dir.mkdirs();
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);

            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalName;
    }

    public String handleSaveUploadProductPicture(MultipartFile file, String targetFolder) {
        // 1. Kiểm tra file rỗng
        if (file.isEmpty()) {
            return "";
        }

        try {
            // 2. Tạo đường dẫn lưu trữ: /webapp/resources/images/{targetFolder}
            // getRealPath("") trả về đường dẫn gốc của ứng dụng đang chạy
            String rootPath = this.servletContext.getRealPath("/resources/images");
            String finalPath = rootPath + File.separator + targetFolder;

            // 3. Tạo thư mục nếu chưa tồn tại
            File dir = new File(finalPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 4. Đổi tên file để tránh trùng lặp (Ví dụ: avatar.png -> 17623123-avatar.png)
            // Dùng System.currentTimeMillis() cho đơn giản, hoặc UUID
            String finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();

            // 5. Lưu file xuống ổ cứng
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);

            // Cách 1: Dùng Stream (Cổ điển)
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
            stream.write(file.getBytes());
            stream.close();

            // Cách 2: Dùng transferTo (Ngắn gọn hơn)
            // file.transferTo(serverFile);

            return finalName;

        } catch (IOException e) {
            e.printStackTrace(); // Ghi log lỗi nếu có
            return "";
        }
    }

    /**
     * Hàm xử lý xóa file
     * 
     * @param fileName     : Tên file cần xóa
     * @param targetFolder : Thư mục chứa file
     */
    public void handleDeleteFile(String fileName, String targetFolder) {
        if (fileName == null || fileName.isEmpty()) {
            return;
        }

        try {
            // 1. Lấy đường dẫn tới file
            String rootPath = this.servletContext.getRealPath("/resources/images");
            String finalPath = rootPath + File.separator + targetFolder + File.separator + fileName;

            // 2. Tạo đối tượng File
            File file = new File(finalPath);

            // 3. Xóa nếu tồn tại
            if (file.exists()) {
                if (file.delete()) {
                    System.out.println("Đã xóa file thành công: " + fileName);
                } else {
                    System.out.println("Không thể xóa file: " + fileName);
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa file: " + e.getMessage());
        }
    }
}
