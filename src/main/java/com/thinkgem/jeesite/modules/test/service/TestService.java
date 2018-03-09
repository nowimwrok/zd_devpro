/**
 * 
 */
package com.thinkgem.jeesite.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.test.dao.TestDao;
import com.thinkgem.jeesite.modules.test.entity.Test;

/**
 * 测试Service
 * @author 
 * @version 2013-10-17
 */
@Service
@Transactional(readOnly = true)
public class TestService extends CrudService<TestDao, Test> {

}
