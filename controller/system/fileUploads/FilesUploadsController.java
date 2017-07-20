package com.maryun.controller.system.fileUploads;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.FilesSaveLocalUtils;
import com.maryun.utils.IOUtils;
import com.maryun.utils.UrlDecode;
import com.maryun.utils.UuidUtil;
import com.maryun.utils.WebResult;

import net.coobird.thumbnailator.Thumbnails;


/**
 * 文件上传
 * FilesUploadsController
 *
 * @author SR
 * @version 2017-02-17
 */
@Controller
@RequestMapping(value = "filesUploads")
public class FilesUploadsController extends BaseController {
    @Value("${system.file.uploads.basePath}")
    public String BASE_PATH;
    @Value("${system.imageServer.uploads.basePath}")
    private String ImageServer;
    @Resource
    private FilesSaveLocalUtils filesSaveLocalUtils;

    @RequestMapping("/upJsp")
    public ModelAndView upJsp() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/filesuploads/fileupload");
        return mv;
    }


    /**
     * 文件上传
     *
     * @param file
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/fileUpd")
    public Object fileUpd(MultipartFile[] file) throws Exception {
        List list = new ArrayList();
        try {
            //获得CREATE_UID
            PageData savePage = this.savePage(getPageData());
            String CREATE_UID = savePage.getString("CREATE_UID");
            String MASTER_ID = this.getPageData().get("MASTER_ID") + "";
            String IDS = this.getPageData().getString("IDS");
            //要覆盖的ID[]
            if (IDS != null && IDS != "") {
                Map deleteSolve = JSON.toJavaObject((JSONObject) deleteSolve(), Map.class);
                if (deleteSolve.get("msg") == "no") {
                    return WebResult.requestFailed(400, "覆盖图片失败", this.getPageData());
                }

            }

            //String yyydd=DateUtil.getMonth();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
            String yyydd = simpleDateFormat.format(new Date());


            for (MultipartFile multipartFile : file) {
                //取得当前上传文件的文件名称
                String fileName = multipartFile.getOriginalFilename();
                String id = UuidUtil.get32UUID();
                //重命名上传后的文件名
                //String filename = fileName.substring(0,fileName.lastIndexOf("."));
                String fileType = fileName.substring(fileName.lastIndexOf("."));

                String newFileName = id + fileType;
                String path = File.separator + yyydd + File.separator + newFileName;

                //定义缩略图路径
                String newFileNameslt = id + "slt" + ".jpg";
                String pathslt = File.separator + yyydd + "slt" + File.separator + newFileNameslt;
                //硬盘路径是否存在，如果不存在则创建
                String dstPath = BASE_PATH + File.separator + yyydd;
                File dstFile = new File(dstPath);
                if (!dstFile.exists()) {
                    dstFile.mkdirs();
                }
                //缩略图硬盘路径是否存在，如果不存在则创建
                String dstPathslt = BASE_PATH + File.separator + yyydd + "slt";
                File dstFileslt = new File(dstPathslt);
                if (!dstFileslt.exists()) {
                    dstFileslt.mkdirs();
                }
                //定义上传路径
                String filePath = BASE_PATH + path;
                //储存图片
                if (!filesSaveLocalUtils.savePhotoToPath(multipartFile, filePath)) {
                    return WebResult.requestFailed(501, "存入文件失败", null);
                }

                Thumbnails.of(BASE_PATH + path)
                        .size(100, 100)
                        .keepAspectRatio(false)
                        .toFile(BASE_PATH + pathslt);
                //"/"符号
                String PathChange = BASE_PATH.replaceAll("\\\\", "/");
                String sltPathChange = pathslt.replaceAll("\\\\", "/");
                String reppath = path.replaceAll("\\\\", "/");
                //保存数据库
                PageData pd = this.getPageData();
                pd.put("ID", id);
                pd.put("FILE_NAME", fileName);
                pd.put("BASE_PATH", PathChange);
                pd.put("PATH", reppath);
                pd.put("THUMBNAILS", sltPathChange);
                pd.put("FILE_SIZE", multipartFile.getSize());
                pd.put("FILE_TYPE", multipartFile.getContentType());
                pd.put("MASTER_ID", MASTER_ID);
                pd.put("STATUS", "0");
                pd.put("CREATE_ID", CREATE_UID);
                pd.put("DEL_STATE", "1");
                //pd.put("CREATE_TIME", new Date());这个日期在server端
                this.pd(systemServer + "filesUploads/fileUpd", pd);
                Map map = new HashMap();
                map.put("id", id);
                map.put("path", ImageServer + reppath);
                map.put("sltpath", ImageServer + sltPathChange);
                list.add(map);
            }


        } catch (IllegalStateException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Im头像上传
     *
     * @param file
     * @return
     * @throws Exception
     */
    @RequestMapping("uploadImHeadPortrait")
    @ResponseBody
    public PageData uploadImHeadPortrait(MultipartFile[] file) throws Exception {
        List pd = (List) fileUpd(file);
        PageData returnPd = new PageData();
            String path = (String) ((HashMap) (pd).get(0)).get("path");
            String sltpath = (String) ((HashMap) (pd).get(0)).get("sltpath");
            PageData returnPd1 = new PageData();
            returnPd1.put("src", path.split(ImageServer)[1]);
            returnPd1.put("srcSlt", sltpath.split(ImageServer)[1]);
            returnPd1.put("imageServer", ImageServer);
            returnPd.put("code", 0);
            returnPd.put("msg", "图片上传成功！");
            returnPd.put("data", returnPd1);
            return returnPd;//WebResult.requestSuccess(returnPd);
//        } else {
//            return WebResult.requestFailed(500, "网络出现故障！", pd.get("content"));
//        }
    }

    /**
     * 列表页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = {"list", ""})
    public String list(Model model) {
        return "system/filesuploads/filesuploads_list";
    }

    /**
     * 查询列表
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "listData")
    public Object listData() {
        PageData pd = this.getPageData();
        return this.pd(systemServer + "filesUploads/listData", UrlDecode.urlDecode(pd));
    }

    /**
     * 新增页面
     *
     * @return String
     */
    @RequestMapping(value = "toAdd")
    public ModelAndView toAdd() {
        PageData pd = new PageData();
        ModelAndView mv = new ModelAndView();
        mv.addObject("pd", pd);
        mv.setViewName("system/filesuploads/filesuploads_add");
        return mv;
    }

    /**
     * 新增
     *
     * @return String
     */
    @RequestMapping(value = "saveAdd")
    @ResponseBody
    public Object saveAdd() throws Exception {
        PageData pd = this.getPageData();
        pd.put("id", UuidUtil.get32UUID());
        //return "system/filesuploads/filesuploads_list";
        return this.pd(systemServer + "filesUploads/saveAdd", pd);
    }

    /**
     * 查看编辑表单
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "toEdit")
    public Object toEdit(Model model) throws Exception {
        PageData pd = this.getPageData();
        //model.addAttribute("pd",filesUploadsData);
        return this.viewAndPd("system/filesuploads/filesuploads_edit", systemServer + "filesUploads/toEdit", pd);
    }

    /**
     * 根据文件ID修改主键ID
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "updateMasterId")
    @ResponseBody
    public Object updateMasterId(Model model) throws Exception {
        PageData pd = this.getPageData();
        return this.pd(systemServer + "filesUploads/updateMasterId", pd);
    }

    /**
     * 保存数据
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "saveEdit")
    //@ResponseBody
    public ModelAndView saveEdit(Model model) throws Exception {
        PageData pd = this.getPageData();
        return this.viewAndPd("system/filesuploads/filesuploads_list", systemServer + "filesUploads/saveEdit", pd);
        //return null;
    }


    /**
     * 删除数据(伪删除)
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteSolve")
    public Object deleteSolve() {
        PageData pd = this.getPageData();
        return this.pd(systemServer + "filesUploads/deleteSolve", pd);
    }


    /**
     * 删除数据通过MASTER_ID(真删除)
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteByMaster")
    public Object deleteByMaster(Model model) {
        PageData pd = this.getPageData();
        return this.pd(systemServer + "filesUploads/deleteByMaster", pd);
    }


    /**
     * 删除数据
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delete")
    public Object delete() {
        PageData pd = this.getPageData();
        return this.pd(systemServer + "filesUploads/delete", pd);
    }

    /**
     * 根据ID获取信息
     *
     * @return Object
     * @throws
     */
    @RequestMapping(value = "/getInforById")
    @ResponseBody
    public Object getInforById() {
        return this.pd(systemServer + "filesUploads/toEdit", this.getPageData());
    }

    /**
     * 下载文件
     *
     * @return
     */
    @RequestMapping(value = "download")
    public Object download(Model model, HttpServletRequest request, HttpServletResponse response) {
        PageData pd = this.getPageData();
        try {
            PageData filesUploadsData = (PageData) this.pd(systemServer + "filesUploads/deleteByMaster", pd);
            if (filesUploadsData == null) {
                return null;
            }
            String fileName = filesUploadsData.getString("FILE_NAME") + "";
            if (StringUtils.isNotBlank(fileName)) {
                response.setCharacterEncoding("utf-8");
                response.setContentType("multipart/form-data");
                response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
                String path = filesUploadsData.getString("BASE_PATH") + filesUploadsData.getString("PATH");
                InputStream inputStream = new FileInputStream(new File(path));
                OutputStream os = response.getOutputStream();
                byte[] b = new byte[2048];
                int length;
                while ((length = inputStream.read(b)) > 0) {
                    os.write(b, 0, length);
                }
                //关闭。
                os.close();
                inputStream.close();
            }
            //filesUploadsData.g
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 返回流
     *
     * @throws IOException
     */
    @RequestMapping("backFile")
    public ResponseEntity<byte[]> backFile() throws IOException {
        PageData pageData = this.getPageData();
        JSONObject json = (JSONObject) this.pd(systemServer + "filesUploads/findById", pageData);
        Map peda = JSON.toJavaObject(json, Map.class);
        String path = (String) peda.get("PATH");
        String fileName = (String) peda.get("FILE_NAME");
        String basePath = (String) peda.get("BASE_PATH");
        byte[] file2byte = IOUtils.File2byte(basePath + path);
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG)
                .contentLength(file2byte.length)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
                .body(file2byte);
    }

    /**
     * @return ResponseEntity<byte[]>
     * @throws IOException
     * @throws
     */
    @RequestMapping("backFileDownload")
    public ResponseEntity<byte[]> backFileDownload() throws IOException {
        PageData pageData = this.getPageData();
        JSONObject json = (JSONObject) this.pd(systemServer + "filesUploads/findById", pageData);
        Map peda = JSON.toJavaObject(json, Map.class);
        String path = (String) peda.get("PATH");
        String fileName = (String) peda.get("FILE_NAME");
        String basePath = (String) peda.get("BASE_PATH");
        byte[] file2byte = IOUtils.File2byte(basePath + path);
        return ResponseEntity.ok().contentLength(file2byte.length).header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                .body(file2byte);
    }

    /**
     * @return
     */
    @RequestMapping("findByHttpIdOrMasterId")
    @ResponseBody
    public Object findByMasterId() {
        PageData pageData = this.getPageData();
        return this.pd(systemServer + "filesUploads/findByHttpIdOrMasterId", pageData);
    }

}