package test3.bean;

import com.jsmartframework.web.adapter.ListAdapter;
import com.jsmartframework.web.annotation.PreSubmit;
import com.jsmartframework.web.annotation.QueryParam;
import com.jsmartframework.web.util.WebText;
import com.jsmartframework.web.manager.WebContext;
import com.jsmartframework.web.annotation.WebBean;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;

import test3.adapter.Adapter;
import test3.service.SpringService;

@WebBean
public class HomeBean {

    @Autowired
    private SpringService springService;

    private String sessionId;

    private String name;

    private String age;

    @PostConstruct
    public void init() {
        sessionId = getSessionId();
    }

    private String getSessionId() {
        Cookie[] cookies = WebContext.getRequest().getCookies();
        for (Cookie cookie : cookies) {
            if ("JSESSIONID".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    public void addContent() {
        Adapter adapter = new Adapter();
        adapter.setName(name);
        adapter.setAge(age);
        springService.putAdapter(sessionId, adapter);

        WebContext.addWarning("feedback", "User ["  + name + "] added to list!");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public MyListAdapter getMyListAdapter() {
        return new MyListAdapter();
    }

    private class MyListAdapter extends ListAdapter<Adapter> {

        @Override
        public List<Adapter> load(int offsetIndex, Object offset, int size) {

            List<Adapter> list = springService.getAdapters(sessionId);

            if (offsetIndex + size <= list.size()) {
                return list.subList(offsetIndex, offsetIndex + size);
            } else {
                return list.subList(offsetIndex, list.size());
            }
        }
    }
}

