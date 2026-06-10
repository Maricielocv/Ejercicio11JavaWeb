package com.sistema.model;

public class Usuario {
    private String usuario;
    private String password;
    private String permisos;
    private String estado;
    private String nombres;

    public Usuario() {}

    // Getters y Setters
    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getPermisos() { return permisos; }
    public void setPermisos(String permisos) { this.permisos = permisos; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }
}