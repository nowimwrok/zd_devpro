package com.thinkgem.jeesite.modules.wlpt.api;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.FileUtils;

/**
 * 文件上传工具类
 */
public class FileUploadUtils {
    private static Logger log = LoggerFactory.getLogger(FileUploadUtils.class);

    /**
     * 文件上传 多个文件
     *
     * @param url
     * @param request
     * @return
     * @throws IOException
     */
    public static Map<String, String> upload(String url, HttpServletRequest request) throws IOException {
        String saveDirectory = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL;
        String datePath = "yyyy/MM";
        SimpleDateFormat sdf = null;
        try {
            if (StringUtils.isNotBlank(datePath)) {
                sdf = new SimpleDateFormat(datePath);
                url += sdf.format(new Date());
            }
        } catch (Exception e) {
            //
            log.error(e.toString());
        }
        saveDirectory = saveDirectory + "/" + url;
        Map<String, String> result = new HashMap<String, String>();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
            MultipartFile file = entity.getValue();
            String oriFileName = file.getOriginalFilename(); // 源文件名称
            FileUtils.copyInputStreamToFile(file.getInputStream(), new File(saveDirectory, oriFileName));

            result.put("fileName", oriFileName);
            result.put("realNamePath", request.getContextPath() + Global.USERFILES_BASE_URL + url + "/" + oriFileName);
        }
        return result;
    }

    /**
     * 文件上传，一次上传一个文件
     *
     * @param url
     * @param file
     * @param request
     * @return
     * @throws IOException
     */
    public static Map<String, String> upload(String url, MultipartFile file, HttpServletRequest request)
            throws IOException {
        String saveDirectory = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL;
        String datePath = "yyyy/MM";
        SimpleDateFormat sdf = null;
        try {
            if (StringUtils.isNotBlank(datePath)) {
                sdf = new SimpleDateFormat(datePath);
                url += sdf.format(new Date());
            }
        } catch (Exception e) {
            //
            log.error(e.toString());
        }
        saveDirectory = saveDirectory + "/" + url;
        Map<String, String> result = new HashMap<String, String>();

        String oriFileName = file.getOriginalFilename(); // 源文件名称
        FileUtils.copyInputStreamToFile(file.getInputStream(), new File(saveDirectory, oriFileName));

        result.put("fileName", oriFileName);
        result.put("realNamePath", request.getContextPath() + Global.USERFILES_BASE_URL + url + "/" + oriFileName);

        return result;

    }

}
