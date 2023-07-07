package com.yyy.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.yyy.entity.User;
import com.yyy.service.UserService;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MultimediaController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private ServletContext servletContext;

    /*
     * CST21030 (2023/7/3):用户上传文件不在WebContent中是正常的
     * 在运行项目时，IDE会自动编译java代码并将WebContent的数据复制到一个新的文件夹中，所有通过Web交互的文件**都在新的文件夹中执行**
     * 例如用户上传的图片会出现在 【\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\[ProjectName]\static\img\】中，而不是当前编写代码的文件夹
     * 
     * 如果以后要自定义头像的话，用户发送后的存储路径也是一样的，数据库中存储UUID即可
     * 
     * 目录路径 \workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\[ProjectName]\
     */
    @RequestMapping(value = "/multi-media/upload", method = {RequestMethod.POST})
    public ResponseEntity<String> uploadMedia(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("未选择文件");
        }

        // 生成唯一的文件名
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();

        try {
            /*
             * CST21030 (2023/7/3):
             * 这里是否对文件类型或大小进行了**后端**硬性限制？
             */

             //新建一个ArrayList用于存储允许的后缀名
            ArrayList<String> allowedFileExtensions = new ArrayList<String>();
            allowedFileExtensions.addAll(Arrays.asList(".bmp", ".jpg", ".png", ".jpeg", ".gif", ".mp4"));	//这里的范围请自行修改

            //如果此时，用户发送的文件不是允许的文件，则直接拒绝上传
            if (!allowedFileExtensions.contains(extension)) {
                throw new Exception("不支持的文件格式");
            }

            //检查文件大小
            if (file.getSize() > 20 * 1024 * 1024) {
            	throw new Exception("文件过大");
            }
            
            String fileName = UUID.randomUUID().toString() + extension;

      //try {
            // 保存文件到指定路径
            // 构建绝对路径
            String absolutePath = servletContext.getRealPath("/static/img");
            File targetFile = new File(absolutePath, fileName);

            FileUtils.writeByteArrayToFile(targetFile, file.getBytes());
            
            // 构建完整的文件访问URL
            String contextPath = request.getContextPath();
            String fileUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/static/img/" + fileName;
            return ResponseEntity.ok(fileUrl);
        }
        catch (Exception e) {
            //e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("文件上传失败");
        }
    }
    
    public boolean deleteFile(String FileID) {
        try {
            // 构建要删除的文件的完整路径
            String absolutePath = servletContext.getRealPath("/static/img");
            String filePath = absolutePath + File.separator + FileID;

            // 创建File对象
            File file = new File(filePath);

            // 删除文件
            return file.delete();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /*
     * CST21030 (2023/7/3):
     * 下面是用户头像的上传
     */
    @RequestMapping(value = "/user-avatar/upload", method = {RequestMethod.POST})
    public ResponseEntity<String> uploadAvatar(HttpServletRequest request, HttpSession session, @RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("未选择文件");
        }

        // 生成唯一的文件名
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();

        try {
        	
             //新建一个ArrayList用于存储允许的后缀名
            ArrayList<String> allowedFileExtensions = new ArrayList<String>();
            allowedFileExtensions.addAll(Arrays.asList(".bmp", ".jpg", ".png", ".jpeg", ".gif"));	//这里的范围请自行修改

            //如果此时，用户发送的文件不是允许的文件，则直接拒绝上传
            if (!allowedFileExtensions.contains(extension)) {
                throw new Exception("不支持的文件格式");
            }

            //检查文件大小
            if (file.getSize() > 1 * 1024 * 1024) {
            	throw new Exception("文件过大");
            }
            
            String fileName = UUID.randomUUID().toString() + extension;

      //try {
            // 保存文件到指定路径
            // 构建绝对路径
            String absolutePath = servletContext.getRealPath("/static/img");
            File targetFile = new File(absolutePath, fileName);

            FileUtils.writeByteArrayToFile(targetFile, file.getBytes());

            //获取用户的UID
            User _user = (User)session.getAttribute("USER_SESSION");
            deleteFile(_user.getDaily_picture());
            
            //将用户新的头像写到数据库中
            userService.updateUserPicture(_user.getUser_code(), fileName);
            
            //daily_picture是用户的头像吗？
            _user.setDaily_picture(fileName);
            
            //把新的数据写到session中
            session.setAttribute("USER_SESSION", _user);
            
            return ResponseEntity.ok(fileName);
        }
        catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("文件上传失败");
        }
    }
}
