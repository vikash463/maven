package test3.service;

import test3.adapter.Adapter;

import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class SpringService {

    private Map<String, List<Adapter>> adapters = new ConcurrentHashMap<>();

    public void putAdapter(String key, Adapter adapter) {
        List<Adapter> list = adapters.get(key);
        if (list == null) {
            list = new ArrayList<>();
            adapters.put(key, list);
        }
        list.add(adapter);
    }

    public List<Adapter> getAdapters(String key) {
        List<Adapter> list = adapters.get(key);
        if (list != null) {
            return list;
        }
        return Collections.emptyList();
    }

    public void removeAdapter(String key, int index) {
        List<Adapter> list = adapters.get(key);
        if (list != null) {
            list.remove(index);
        }
    }
}
