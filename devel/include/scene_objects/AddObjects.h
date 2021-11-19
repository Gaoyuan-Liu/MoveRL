// Generated by gencpp from file scene_objects/AddObjects.msg
// DO NOT EDIT!


#ifndef SCENE_OBJECTS_MESSAGE_ADDOBJECTS_H
#define SCENE_OBJECTS_MESSAGE_ADDOBJECTS_H

#include <ros/service_traits.h>


#include <scene_objects/AddObjectsRequest.h>
#include <scene_objects/AddObjectsResponse.h>


namespace scene_objects
{

struct AddObjects
{

typedef AddObjectsRequest Request;
typedef AddObjectsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct AddObjects
} // namespace scene_objects


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::scene_objects::AddObjects > {
  static const char* value()
  {
    return "52787aaffa634714d435fdc99358732c";
  }

  static const char* value(const ::scene_objects::AddObjects&) { return value(); }
};

template<>
struct DataType< ::scene_objects::AddObjects > {
  static const char* value()
  {
    return "scene_objects/AddObjects";
  }

  static const char* value(const ::scene_objects::AddObjects&) { return value(); }
};


// service_traits::MD5Sum< ::scene_objects::AddObjectsRequest> should match
// service_traits::MD5Sum< ::scene_objects::AddObjects >
template<>
struct MD5Sum< ::scene_objects::AddObjectsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::scene_objects::AddObjects >::value();
  }
  static const char* value(const ::scene_objects::AddObjectsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::scene_objects::AddObjectsRequest> should match
// service_traits::DataType< ::scene_objects::AddObjects >
template<>
struct DataType< ::scene_objects::AddObjectsRequest>
{
  static const char* value()
  {
    return DataType< ::scene_objects::AddObjects >::value();
  }
  static const char* value(const ::scene_objects::AddObjectsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::scene_objects::AddObjectsResponse> should match
// service_traits::MD5Sum< ::scene_objects::AddObjects >
template<>
struct MD5Sum< ::scene_objects::AddObjectsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::scene_objects::AddObjects >::value();
  }
  static const char* value(const ::scene_objects::AddObjectsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::scene_objects::AddObjectsResponse> should match
// service_traits::DataType< ::scene_objects::AddObjects >
template<>
struct DataType< ::scene_objects::AddObjectsResponse>
{
  static const char* value()
  {
    return DataType< ::scene_objects::AddObjects >::value();
  }
  static const char* value(const ::scene_objects::AddObjectsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SCENE_OBJECTS_MESSAGE_ADDOBJECTS_H