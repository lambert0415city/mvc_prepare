package com.cs.pojo;
import java.io.*;
/**
 * @author: szh
 * @since:
 */
public class RabbitMessage implements Serializable {
    /**
     * 参数类型
     */
    private Class<?>[] paramTypes ;
    /**
     *  交换器
     */
    private String exchange;

    private Object[] params;
    /**
     * 路由key
     */
    private String routekey;

    public RabbitMessage() {
    }

    public RabbitMessage(String exchange,  String routekey,Object...params) {
        this.exchange = exchange;
        this.params = params;
        this.routekey = routekey;
    }

    @SuppressWarnings("rawtypes")
    public RabbitMessage(String exchange,String routeKey,String methodName,Object...params)
    {
        this.params=params;
        this.exchange=exchange;
        this.routekey=routeKey;
        int len=params.length;
        Class[] clazzArray=new Class[len];
        for(int i=0;i<len;i++) {
            clazzArray[i] = params[i].getClass();
        }
        this.paramTypes=clazzArray;
    }

    public byte[] getSerialBytes(){
        byte[] res = new byte[0];
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ObjectOutput oos ;
        try {
            oos = new ObjectOutputStream(baos);
            oos.writeObject(this);
            oos.close();
            res = baos.toByteArray();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return res;
    }

    public Class<?>[] getParamTypes() {
        return paramTypes;
    }

    public void setParamTypes(Class<?>[] paramTypes) {
        this.paramTypes = paramTypes;
    }

    public String getExchange() {
        return exchange;
    }

    public void setExchange(String exchange) {
        this.exchange = exchange;
    }

    public Object[] getParams() {
        return params;
    }

    public void setParams(Object[] params) {
        this.params = params;
    }

    public String getRoutekey() {
        return routekey;
    }

    public void setRoutekey(String routekey) {
        this.routekey = routekey;
    }
}
