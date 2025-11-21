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
        if (file.isEmpty()) {
            return "";
        }

        try {
            String rootPath = this.servletContext.getRealPath("/resources/images");
            String finalPath = rootPath + File.separator + targetFolder;
            File dir = new File(finalPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            String finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();

            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
            stream.write(file.getBytes());
            stream.close();
            return finalName;

        } catch (IOException e) {
            e.printStackTrace();
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
            String rootPath = this.servletContext.getRealPath("/resources/images");
            String finalPath = rootPath + File.separator + targetFolder + File.separator + fileName;
            File file = new File(finalPath);
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
